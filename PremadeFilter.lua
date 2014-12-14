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
--[[
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
]]--
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
