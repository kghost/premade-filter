MAX_LFG_LIST_GROUP_DROPDOWN_ENTRIES = 1000;

function PremadeFilter_Frame_OnLoad(self)
	--LFGListFrame.SearchPanel.CategoryName:Hide();
	LFGListFrame.SearchPanel.SearchBox:SetSize(205, 18);

	self.AdvancedButton:SetParent(LFGListFrame.SearchPanel);
	self.AdvancedButton:SetPoint("TOPRIGHT", LFGListFrame.SearchPanel, "TOPRIGHT", -10, -55);
	
	self:SetParent(LFGListFrame.SearchPanel);
	self:SetPoint("TOPLEFT", LFGListFrame.SearchPanel, "TOPRIGHT", 10, -20);
	--self:SetParent(LFGListFrame.EntryCreation);
	--self:SetPoint("TOPLEFT", LFGListFrame.EntryCreation, "TOPRIGHT", 10, -20);

	self.Name.Instructions:SetText(LFG_LIST_ENTER_NAME);
	self.Description.EditBox:SetScript("OnEnterPressed", nop);
	
	LFGListUtil_SetUpDropDown(self, self.CategoryDropDown, LFGListEntryCreation_PopulateCategories, LFGListEntryCreation_OnCategorySelected);
	LFGListUtil_SetUpDropDown(self, self.GroupDropDown, LFGListEntryCreation_PopulateGroups, LFGListEntryCreation_OnGroupSelected);
	LFGListUtil_SetUpDropDown(self, self.ActivityDropDown, LFGListEntryCreation_PopulateActivities, LFGListEntryCreation_OnActivitySelected);
	LFGListEntryCreation_SetBaseFilters(self, 0);

	--PremadeFilter_Frame.NameLabel:SetPoint("LEFT", PremadeFilter_Frame, "TOPLEFT", 20, -163);
	
--[[
	self:RegisterEvent("LFG_LIST_AVAILABILITY_UPDATE");
	self:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE");
	self:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED");
	self:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED");
	self:RegisterEvent("LFG_LIST_SEARCH_FAILED");
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("UNIT_CONNECTION");
	for i=1, #LFG_LIST_ACTIVE_QUEUE_MESSAGE_EVENTS do
		self:RegisterEvent(LFG_LIST_ACTIVE_QUEUE_MESSAGE_EVENTS[i]);
	end
]]--
	self.baseFilters = LE_LFG_LIST_FILTER_PVE;
	self.selectedFilters = LE_LFG_LIST_FILTER_PVE;
--[[
	LFGListFrame_SetActivePanel(self, self.NothingAvailable);

	self.EventsInBackground = {
		LFG_LIST_SEARCH_FAILED = { self.SearchPanel };
	};
]]--
end

function LFGListEntryCreation_PopulateGroups(self, dropDown, info)
	if ( not self.selectedCategory ) then
		--We don't have a category, so we can't fill out groups.
		return;
	end

	local useMore = false;

	--Start out displaying everything
	local groups = C_LFGList.GetAvailableActivityGroups(self.selectedCategory, bit.bor(self.baseFilters, self.selectedFilters));
	local activities = C_LFGList.GetAvailableActivities(self.selectedCategory, 0, bit.bor(self.baseFilters, self.selectedFilters));
	
	local groupOrder = groups[1] and select(2, C_LFGList.GetActivityGroupInfo(groups[1]));
	local activityOrder = activities[1] and select(10, C_LFGList.GetActivityInfo(activities[1]));

	local groupIndex, activityIndex = 1, 1;

	--Start merging
	for i=1, MAX_LFG_LIST_GROUP_DROPDOWN_ENTRIES do
		if ( not groupOrder and not activityOrder ) then
			break;
		end

		if ( activityOrder and (not groupOrder or activityOrder < groupOrder) ) then
			local activityID = activities[activityIndex];
			local name = select(ACTIVITY_RETURN_VALUES.shortName, C_LFGList.GetActivityInfo(activityID));

			info.text = name;
			info.value = activityID;
			info.arg1 = "activity";
			info.checked = (self.selectedActivity == activityID);
			info.isRadio = true;
			UIDropDownMenu_AddButton(info);

			activityIndex = activityIndex + 1;
			activityOrder = activities[activityIndex] and select(10, C_LFGList.GetActivityInfo(activities[activityIndex]));
		else
			local groupID = groups[groupIndex];
			local name = C_LFGList.GetActivityGroupInfo(groupID);

			info.text = name;
			info.value = groupID;
			info.arg1 = "group";
			info.checked = (self.selectedGroup == groupID);
			info.isRadio = true;
			UIDropDownMenu_AddButton(info);

			groupIndex = groupIndex + 1;
			groupOrder = groups[groupIndex] and select(2, C_LFGList.GetActivityGroupInfo(groups[groupIndex]));
		end
	end

	if ( #activities + #groups > MAX_LFG_LIST_GROUP_DROPDOWN_ENTRIES ) then
		useMore = true;
	end

	if ( useMore ) then
		info.text = LFG_LIST_MORE;
		info.value = nil;
		info.arg1 = "more";
		info.notCheckable = true;
		info.checked = false;
		info.isRadio = false;
		UIDropDownMenu_AddButton(info);
	end
end

function PrintTable(t, level)
	level = level or 0;
	table.foreach(t, function(k,v)
		if (type(v) == "table") then
			print(string.rep("  ", level)..k..": ");
			PrintTable(v, level + 1);
		else
			print(string.rep("  ", level)..k..": "..v);
		end
	end);
end

--[[
function PremadeFilter_Button_OnClick(self)
	ToggleDropDownMenu(1, nil, PremadeFilter_Options, PremadeFilter_Button, 0, 0);
end

function PremadeFilter_Options_OnLoad(self, level)
	if not level then
		return
	end
	
	if (level == 1) then
		local categories = C_LFGList.GetAvailableCategories();
		
		for i=1, #categories do
			local info = UIDropDownMenu_CreateInfo();
			
			local categoryID = categories[i];
			local categoryName, separateRecommended, autoChoose, preferCurrentArea = C_LFGList.GetCategoryInfo(categoryID);
			
			local groups = C_LFGList.GetAvailableActivityGroups(categoryID, 0);
			if next(groups) ~= nil then
				info.hasArrow = true;
			else
				info.hasArrow = false;
			end
			
			info.notCheckable = false;
			info.text = categoryName;
			info.func = PremadeFilter_Options_OnClick;
			info.value = {
				["category"] = {
					["ID"] = categoryID;
					["name"] = categoryName;
				};
			}
			
			UIDropDownMenu_AddButton(info, 1);
		end
	end
	
	if (level == 2) then
		local category = UIDROPDOWNMENU_MENU_VALUE["category"];
		
		local groups = C_LFGList.GetAvailableActivityGroups(category["ID"], 0);
		
		for i=1, #groups do
			local info = UIDropDownMenu_CreateInfo();
			
			local groupID = groups[i];
			local groupName = C_LFGList.GetActivityGroupInfo(groupID);
			
			local activities = C_LFGList.GetAvailableActivities(browseCategory, groupID, 0, "");
			if next(groups) ~= nil then
				info.hasArrow = true;
			else
				info.hasArrow = false;
			end
			
			info.notCheckable = false;
			info.text = groupName;
			info.func = PremadeFilter_Options_OnClick;
			info.value = {
				["category"] = category;
				["group"] = {
					["ID"] = groupID;
					["name"] = groupName;
				};
			};
			
			UIDropDownMenu_AddButton(info, level);
		end
	end
	
	if (level == 3) then
		local category = UIDROPDOWNMENU_MENU_VALUE["category"];
		local group = UIDROPDOWNMENU_MENU_VALUE["group"];
		
		local activities = C_LFGList.GetAvailableActivities(category["ID"], group["ID"], 0, "");
		
		for i=1, #activities do
			local info = UIDropDownMenu_CreateInfo();
			
			local activityID = activities[i];
			local activityName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
			
			info.hasArrow = false;
			info.notCheckable = false;
			info.text = shortName;
			info.func = PremadeFilter_Options_OnClick;
			info.value = {
				["category"] = category;
				["group"] = group;
				["activity"] = {
					["ID"] = activityID;
					["name"] = shortName;
				};
			};
			
			UIDropDownMenu_AddButton(info, level);
		end
	end
end

function PremadeFilter_Options_OnClick(self, arg1, arg2, checked)
	local value = self.value;
	local categoryName = "";
	
	if value["category"] then
		categoryName = value["category"]["name"];
	end
	
	if value["group"] then
		categoryName = categoryName.." - "..value["group"]["name"];
	end
	
	if value["activity"] then
		categoryName = categoryName.." - "..value["activity"]["name"];
	end
	
	PremadeFilter_Title:SetText(categoryName);
end

function PremadeFilter_Options_GetExpansion(categoryID, activityID)
	local expansions = {
		[3] = {
			[9]		= LE_EXPANSION_CLASSIC,
			[293]	= LE_EXPANSION_CLASSIC,
			[294]	= LE_EXPANSION_CLASSIC,
			[295]	= LE_EXPANSION_CLASSIC,
		}
	}
	
	local category = expansions[categoryID];
	if category then
		local expansion = category[activityID];
		if expansion then
			return {
				["expansionID"] = expansion;
				["expansionName"] = _G["EXPANSION_NAME"..expansion];
			}
		end
	end
	
	return false;
end

function LFGListSearchPanel_DoSearch(self)
	local searchText = "";--self.SearchBox:GetText();
	C_LFGList.Search(self.categoryID, searchText, self.filters, self.preferredFilters);
	self.searching = true;
	self.searchFailed = false;
	self.selectedResult = nil;
	LFGListSearchPanel_UpdateResultList(self);
	LFGListSearchPanel_UpdateResults(self);
end

function LFGListSearchPanel_UpdateResultList(self)
	self.totalResults, self.results = C_LFGList.GetSearchResults();
	self.applications = C_LFGList.GetApplications();
	
	local searchText = self.SearchBox:GetText():lower();
	
	if searchText ~= "" then
		local words = {}
		for w in searchText:gmatch("%S+") do table.insert(words, w) end
		
		local include = {}
		local exclude = {}
		
		for i,w in pairs(words) do
			if w:sub(1,1) ~= "-" then
				table.insert(include, w)
			else
				w = w:sub(2, w:len());
				if w ~= "" then
					table.insert(exclude, w)
				end
			end
		end
		
		local numResults = 0;
		local newResults = {};
		for i=1, #self.results do
			local matches = true;

			local id, activityID, name, comment, voiceChat, iLvl, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted = C_LFGList.GetSearchResultInfo(self.results[i]);
			local activityName = C_LFGList.GetActivityInfo(activityID);

			name = name:lower();

			for i,w in pairs(include) do
				local nameMatch = name:find(w);
				if nameMatch == nil then
					matches = false;
					break 
				end
			end
			
			if matches then
				for i,w in pairs(exclude) do
					local nameMatch = name:find(w);
					if nameMatch ~= nil then
						matches = false;
						break 
					end
				end
			end
			
			if matches then
				numResults = numResults + 1
				newResults[numResults] = self.results[i];
			end
		end

		self.totalResults = numResults;
		self.results = newResults;
	end
	
	LFGListUtil_SortSearchResults(self.results);
end

function LFGListSearchPanel_UpdateResults(self)
	local offset = HybridScrollFrame_GetOffset(self.ScrollFrame);
	local buttons = self.ScrollFrame.buttons;

	--If we have an application selected, deselect it.
	LFGListSearchPanel_ValidateSelected(self);

	if ( self.searching ) then
		self.SearchingSpinner:Show();
		self.ScrollFrame.NoResultsFound:Hide();
		self.ScrollFrame.StartGroupButton:Hide();
		for i=1, #buttons do
			buttons[i]:Hide();
		end
	else
		self.SearchingSpinner:Hide();
		local results = self.results;
		local apps = self.applications;

		for i=1, #buttons do
			local button = buttons[i];
			local idx = i + offset;
			local result = (idx <= #apps) and apps[idx] or results[idx - #apps];

			if ( result ) then
				button.resultID = result;
				LFGListSearchEntry_Update(button);
				button:Show();
			else
				button.resultID = nil;
				button:Hide();
			end
		end

		local totalHeight = buttons[1]:GetHeight() * (#results + #apps);

		--Reanchor the errors to not overlap applications
		if ( totalHeight < self.ScrollFrame:GetHeight() ) then
			self.ScrollFrame.NoResultsFound:SetPoint("TOP", self.ScrollFrame, "TOP", 0, -totalHeight - 27);
		end
		self.ScrollFrame.NoResultsFound:SetShown(self.totalResults == 0);
		self.ScrollFrame.StartGroupButton:SetShown(self.totalResults == 0 and not self.searchFailed);
		self.ScrollFrame.NoResultsFound:SetText(self.searchFailed and LFG_LIST_SEARCH_FAILED or LFG_LIST_NO_RESULTS_FOUND);

		HybridScrollFrame_Update(self.ScrollFrame, totalHeight, self.ScrollFrame:GetHeight());
	end
	LFGListSearchPanel_UpdateButtonStatus(self);
end
]]--