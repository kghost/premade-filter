MAX_LFG_LIST_GROUP_DROPDOWN_ENTRIES = 1000;

function PremadeFilter_Frame_OnLoad(self)
	LFGListFrame.SearchPanel.SearchBox:SetSize(205, 18);

	self.AdvancedButton:SetParent(LFGListFrame.SearchPanel);
	self.AdvancedButton:SetPoint("TOPRIGHT", LFGListFrame.SearchPanel, "TOPRIGHT", -10, -55);
	
	self:SetParent(LFGListFrame.SearchPanel);
	self:SetPoint("TOPLEFT", LFGListFrame.SearchPanel, "TOPRIGHT", 10, -20);

	self.Name.Instructions:SetText(LFG_LIST_ENTER_NAME);
	self.Description.EditBox:SetScript("OnEnterPressed", nop);
	
	LFGListUtil_SetUpDropDown(self, self.CategoryDropDown, LFGListEntryCreation_PopulateCategories, PremadeFilter_OnCategorySelected);
	LFGListUtil_SetUpDropDown(self, self.GroupDropDown, LFGListEntryCreation_PopulateGroups, PremadeFilter_OnGroupSelected);
	LFGListUtil_SetUpDropDown(self, self.ActivityDropDown, LFGListEntryCreation_PopulateActivities, PremadeFilter_OnActivitySelected);
	LFGListEntryCreation_SetBaseFilters(self, 0);
	
	self.baseFilters = LE_LFG_LIST_FILTER_PVE;
	self.selectedFilters = LE_LFG_LIST_FILTER_PVE;
end

function PremadeFilter_OnShow(self)
	local selectedCategory = LFGListFrame.CategorySelection.selectedCategory;
	local selectedFilters = LFGListFrame.CategorySelection.selectedFilters;
	
	--LFGListFrame_SetBaseFilters(LFGListFrame, LE_LFG_LIST_FILTER_PVP);
	
	PremadeFilter_Frame.selectedCategory = selectedCategory;
	PremadeFilter_Frame.selectedFilters = selectedFilters;
	
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
	LFGListSearchPanel_SetCategory(LFGListFrame.SearchPanel, PremadeFilter_Frame.selectedCategory, PremadeFilter_Frame.selectedFilters, PremadeFilter_Frame.selectedFilters);
	LFGListSearchPanel_DoSearch(self:GetParent():GetParent());
end

function PremadeFilter_OnCategorySelected(self, id, filters)
	PremadeFilter_Frame.selectedCategory = id;
	PremadeFilter_Frame.selectedFilters = filters;
	
	LFGListCategorySelection_SelectCategory(LFGListFrame.CategorySelection, id, filters);
	LFGListEntryCreation_OnCategorySelected(self, id, filters)
end

function PremadeFilter_OnGroupSelected(self, id, buttonType)
	PremadeFilter_Frame.selectedGroup = id;
	
	LFGListEntryCreation_OnGroupSelected(self, id, buttonType);
end

function PremadeFilter_OnActivitySelected(self, id, buttonType)
	PremadeFilter_Frame.selectedActivity = id;
	
	LFGListEntryCreation_OnActivitySelected(self, id, buttonType);
end

function LFGListEntryCreation_PopulateGroups(self, dropDown, info)
	if ( not self.selectedCategory ) then
		--We don't have a category, so we can't fill out groups.
		return;
	end

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
end

function LFGListSearchPanel_DoSearch(self)
	local visible = PremadeFilter_Frame:IsVisible();
	local category = PremadeFilter_Frame.selectedCategory;
	
	--print("VISIBLE");
	--print(visible);
	--print("CATEGORY");
	--print(category);
	--print("SELF.CATEGORY");
	--print(self.categoryID);
	--print("self.filters");
	--print(self.filters);
	--print("self.preferredFilters");
	--print(self.preferredFilters);
	--print("===");
	
	if visible and category then
		C_LFGList.Search(category, "", self.filters, self.preferredFilters);
	else
		local searchText = self.SearchBox:GetText();
		C_LFGList.Search(self.categoryID, searchText, self.filters, self.preferredFilters);
	end
	
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
	local include, exclude = PremadeFilter_ParseQuery(searchText);

	--print("INCLUDE");
	--PrintTable(include);
	--print("EXCLUDE");
	--PrintTable(exclude);
	
	local numResults = 0;
	local newResults = {};
	
	for i=1, #self.results do
		local id, activityID, name, comment, voiceChat, iLvl, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted = C_LFGList.GetSearchResultInfo(self.results[i]);
		local activityName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
		
		--print("NAME "..name);
		
		local matches = PremadeFilter_IsStringMatched(name:lower(), include, exclude);
		
		--print("MATCHES");
		--print(matches);
		
		-- check additional filters
		if PremadeFilter_Frame:IsVisible() then
			-- description
			local descrText = PremadeFilter_Frame.Description.EditBox:GetText();
			if descrText ~= "" then
				local descrInclude, descrExclude = PremadeFilter_ParseQuery(descrText);
				local descrMatches = PremadeFilter_IsStringMatched(comment:lower(), descrInclude, descrExclude);
				matches = matches and descrMatches;
			end
			
			-- item level
			if PremadeFilter_Frame.ItemLevel.CheckButton:GetChecked() then
				local ilvlText = tonumber(PremadeFilter_Frame.ItemLevel.EditBox:GetText());
				if ilvlText then
					local ilvlMatches = (iLvl <= ilvlText);
					matches = matches and ilvlMatches;
				end
			end
			
			-- voice chat
			if PremadeFilter_Frame.VoiceChat.CheckButton:GetChecked() then
				local vcText = PremadeFilter_Frame.VoiceChat.EditBox:GetText();
				if vcText ~= "" then
					local vcMatches = (voiceChat:lower() == vcText:lower());
					matches = matches and vcMatches;
				else
					local vcMatches = (voiceChat ~= "");
					matches = matches and vcMatches;
				end
			end
			
			-- category
			local category = PremadeFilter_Frame.selectedCategory;
			if category then
				--print("CATEGORY "..category.." / "..categoryID);
				local categoryMatches = (categoryID == category);
				matches = matches and categoryMatches;
				
			end
			
			-- group
			local group = PremadeFilter_Frame.selectedGroup;
			if group then
				--print("GROUP "..group.." / "..groupID);
				local groupMatches = (groupID == group);
				matches = matches and groupMatches;
				
			end
			
			-- activity
			local activity = PremadeFilter_Frame.selectedActivity;
			if activity then
				--print("ACTIVITY "..activity.." / "..activityID);
				local activityMatches = (activityID == activity);
				matches = matches and activityMatches;
				
			end
		end
		
		-- RESULT
		if matches then
			numResults = numResults + 1
			newResults[numResults] = self.results[i];
		end
	end

	self.totalResults = numResults;
	self.results = newResults;
	
	LFGListUtil_SortSearchResults(self.results);
end

function PremadeFilter_ParseQuery(searchText)
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
	
	return include, exclude;
end

function PremadeFilter_IsStringMatched(str, include, exclude)
	local matches = true;
	
	if next(include) ~= nil then
		for i,w in pairs(include) do
			local nameMatch = str:find(w);
			if nameMatch == nil then
				matches = false;
				break 
			end
		end
	end
	
	if matches and next(exclude) ~= nil then
		for i,w in pairs(exclude) do
			local nameMatch = str:find(w);
			if nameMatch ~= nil then
				matches = false;
				break 
			end
		end
	end
	
	return matches;
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
