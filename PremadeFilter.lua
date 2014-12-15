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
	
	--print("CATEGORY: "..LFGListFrame.CategorySelection.selectedCategory);
	--PrintTable(LFGListFrame.CategorySelection);
	
	self.baseFilters = LE_LFG_LIST_FILTER_PVE;
	self.selectedFilters = LE_LFG_LIST_FILTER_PVE;
end

function PremadeFilter_OnShow(self)
	local selectedCategory = LFGListFrame.CategorySelection.selectedCategory;
	local selectedFilters = LFGListFrame.CategorySelection.selectedFilters;
	LFGListEntryCreation_Select(PremadeFilter_Frame, selectedFilters, selectedCategory, nil, nil);
	
	LFGListFrameSearchBox_OnTextChanged(LFGListFrame.SearchPanel.SearchBox);
	LFGListFrame.SearchPanel.SearchBox:SetScript("OnTextChanged", LFGListFrameSearchBox_OnTextChanged);
end

function LFGListFrameSearchBox_OnTextChanged(self)
	local text = self:GetText();
	PremadeFilter_Frame.Name:SetText(text);
	InputBoxInstructions_OnTextChanged(self);
end

function PremadeFilter_FilterButton_OnClick(self)
	LFGListSearchPanel_DoSearch(self:GetParent():GetParent());
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
	local include = {}
	local exclude = {}
	
	if searchText ~= "" then
		local words = {}
		for w in searchText:gmatch("%S+") do table.insert(words, w) end
		
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
	end
	
	local numResults = 0;
	local newResults = {};
	
	for i=1, #self.results do
		local matches = true;

		local id, activityID, name, comment, voiceChat, iLvl, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted = C_LFGList.GetSearchResultInfo(self.results[i]);
		local activityName = C_LFGList.GetActivityInfo(activityID);

		name = name:lower();

		if next(include) ~= nil then
			for i,w in pairs(include) do
				local nameMatch = name:find(w);
				if nameMatch == nil then
					matches = false;
					break 
				end
			end
		end
		
		if matches and next(exclude) ~= nil then
			for i,w in pairs(exclude) do
				local nameMatch = name:find(w);
				if nameMatch ~= nil then
					matches = false;
					break 
				end
			end
		end
		
		-- check additional filters
		if PremadeFilter_Frame:IsVisible() then
			--print("ADVANCED SEARCH");
		else
			--print("SIMPLE SEARCH");
		end
		
		if matches then
			numResults = numResults + 1
			newResults[numResults] = self.results[i];
		end
	end

	self.totalResults = numResults;
	self.results = newResults;
	
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
--[[
function PrintTable(t, level)
	level = level or 0;
	table.foreach(t, function(k,v)
		if (type(v) == "table") then
			print(string.rep("  ", level)..k..": ");
			PrintTable(v, level + 1);
		elseif (type(v) ~= "userdata") then
			print(string.rep("  ", level)..k..": "..v);
		end
	end);
end
]]--