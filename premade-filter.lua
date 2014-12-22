MAX_LFG_LIST_GROUP_DROPDOWN_ENTRIES = 1000;
LFG_LIST_FRESH_FONT_COLOR = {r=0.3, g=0.9, b=0.3};

function PremadeFilter_Frame_OnLoad(self)
	LFGListFrame.SearchPanel.SearchBox:SetSize(205, 18);
	LFGListFrame.EntryCreation.Description:SetSize(283, 22);
	LFGListFrame.EntryCreation.Description.EditBox:SetMaxLetters(LFGListFrame.EntryCreation.Description.EditBox:GetMaxLetters()-2);
	
	LFGListFrame.EntryCreation.ItemLevel.CheckButton:SetScript("OnClick", PremadeFilter_CheckButton_Editbox_OnClick);
	LFGListFrame.EntryCreation.ItemLevel.EditBox:SetScript("OnEditFocusLost", nop);
	LFGListFrame.EntryCreation.ItemLevel.EditBox:Hide();
	
	LFGListFrame.EntryCreation.VoiceChat.CheckButton:SetScript("OnClick", PremadeFilter_CheckButton_Editbox_OnClick);
	LFGListFrame.EntryCreation.VoiceChat.EditBox:SetScript("OnEditFocusLost", nop);
	LFGListFrame.EntryCreation.VoiceChat.EditBox:Hide();
	
	PremadeFilter_Roles:SetParent(LFGListFrame.EntryCreation);
	PremadeFilter_Roles:SetPoint("TOPLEFT", LFGListFrame.EntryCreation, "TOPLEFT", -10, -20);
	
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
	self.results = {};
end

function PremadeFilter_OnShow(self)
	local categoryID = LFGListFrame.categoryID
	local baseFilters = LFGListFrame.baseFilters;
	
	PremadeFilter_Frame.categoryID = categoryID;
	PremadeFilter_Frame.baseFilters = baseFilters;

	local selectedCategory = LFGListFrame.CategorySelection.selectedCategory;
	local selectedFilters = LFGListFrame.CategorySelection.selectedFilters;
	
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
	
	if visible and category then
		C_LFGList.Search(category, "", self.filters, self.preferredFilters);
	else
		local searchText = self.SearchBox:GetText();
		C_LFGList.Search(self.categoryID, searchText, self.filters, self.preferredFilters);
	end
	
	self.searching = true;
	self.searchFailed = false;
	self.selectedResult = nil;
	
	local totalResults, results = C_LFGList.GetSearchResults();
	local ageMin = nil;
	
	for i=1, #results do
		local id, activityID, name, comment, voiceChat, iLvl, age = C_LFGList.GetSearchResultInfo(results[i]);
		if not ageMin or age < ageMin then
			ageMin = age;
		end
	end
	
	if not ageMin then
		ageMin = 0;
	end
	PremadeFilter_Frame.updated = time() - ageMin + 1;
	
	LFGListSearchPanel_UpdateResultList(self);
	LFGListSearchPanel_UpdateResults(self);
end

function LFGListSearchPanel_UpdateResultList(self)
	self.totalResults, self.results = C_LFGList.GetSearchResults();
	self.applications = C_LFGList.GetApplications();
	
	local searchText = self.SearchBox:GetText():lower();
	local include, exclude, possible = PremadeFilter_ParseQuery(searchText);

	local numResults = 0;
	local newResults = {};
	
	for i=1, #self.results do
		local id, activityID, name, comment, voiceChat, iLvl, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted = C_LFGList.GetSearchResultInfo(self.results[i]);
		local activityName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
		
		local matches = PremadeFilter_IsStringMatched(name:lower(), include, exclude, possible);
		
		-- check additional filters
		if PremadeFilter_Frame:IsVisible() then
			-- description
			local descrText = PremadeFilter_Frame.Description.EditBox:GetText();
			if descrText ~= "" then
				local descrInclude, descrExclude, descrPossible = PremadeFilter_ParseQuery(descrText);
				local descrMatches = PremadeFilter_IsStringMatched(comment:lower(), descrInclude, descrExclude, descrPossible);
				matches = matches and descrMatches;
			end
			
			-- item level
			if PremadeFilter_Frame.ItemLevel.CheckButton:GetChecked() then
				local ilvlText = tonumber(PremadeFilter_Frame.ItemLevel.EditBox:GetText());
				if ilvlText then
					local ilvlMatches = (iLvl >= ilvlText);
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
				local categoryMatches = (categoryID == category);
				matches = matches and categoryMatches;
				
			end
			
			-- group
			local group = PremadeFilter_Frame.selectedGroup;
			if group then
				local groupMatches = (groupID == group);
				matches = matches and groupMatches;
				
			end
			
			-- activity
			local activity = PremadeFilter_Frame.selectedActivity;
			if activity then
				local activityMatches = (activityID == activity);
				matches = matches and activityMatches;
			end
			
			-- roles
			local tank = PremadeFilter_Frame.TankCheckButton:GetChecked();
			local heal = PremadeFilter_Frame.HealerCheckButton:GetChecked();
			local dps  = PremadeFilter_Frame.DamagerCheckButton:GetChecked();
			local roles = 0;
			
			if tank or heal or dps then
				if tank then roles = roles+4 end
				if heal then roles = roles+2 end
				if dps  then roles = roles+1 end
				
				-- check if premade has role bit mask
				local lastWord = string.sub(comment, comment:len()-1);
				local byte1 = string.byte(lastWord, 1, 1);
				local byte2 = string.byte(lastWord, 2, 2);
				
				if byte1 == 194 and byte2 >=128 and byte2 <= 135 then
					local roleMatches = bit.band(roles, byte2-128) ~= 0;
					matches = matches and roleMatches;
				end
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
				button.created = 0;
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

function LFGListSearchEntry_Update(self)
	local resultID = self.resultID;
	local _, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(resultID);
	local isApplication = (appStatus ~= "none" or pendingStatus);
	local isAppFinished = LFGListUtil_IsStatusInactive(appStatus) or LFGListUtil_IsStatusInactive(pendingStatus);

	--Update visibility based on whether we're an application or not
	self.isApplication = isApplication;
	self.ApplicationBG:SetShown(isApplication and not isAppFinished);
	self.ResultBG:SetShown(not isApplication or isAppFinished);
	self.DataDisplay:SetShown(not isApplication);
	self.CancelButton:SetShown(isApplication and pendingStatus ~= "applied");
	self.CancelButton:SetEnabled(LFGListUtil_IsAppEmpowered());
	self.CancelButton.Icon:SetDesaturated(not LFGListUtil_IsAppEmpowered());
	self.CancelButton.tooltip = (not LFGListUtil_IsAppEmpowered()) and LFG_LIST_APP_UNEMPOWERED;
	self.Spinner:SetShown(pendingStatus == "applied");
	
	if ( pendingStatus == "applied" and C_LFGList.GetRoleCheckInfo() ) then
		self.PendingLabel:SetText(LFG_LIST_ROLE_CHECK);
		self.PendingLabel:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( pendingStatus == "cancelled" or appStatus == "cancelled" or appStatus == "failed" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_CANCELLED);
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "declined" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_DECLINED);
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "timedout" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_TIMED_OUT);
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "invited" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_INVITED);
		self.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "inviteaccepted" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_INVITE_ACCEPTED);
		self.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "invitedeclined" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_INVITE_DECLINED);
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( isApplication and pendingStatus ~= "applied" ) then
		self.PendingLabel:SetText(LFG_LIST_PENDING);
		self.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Show();
		self.CancelButton:Show();
	else
		self.PendingLabel:Hide();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	end

	--Center justify if we're on more than one line
	if ( self.PendingLabel:GetHeight() > 15 ) then
		self.PendingLabel:SetJustifyH("CENTER");
	else
		self.PendingLabel:SetJustifyH("RIGHT");
	end

	--Change the anchor of the label depending on whether we have the expiration time
	if ( self.ExpirationTime:IsShown() ) then
		self.PendingLabel:SetPoint("RIGHT", self.ExpirationTime, "LEFT", -3, 0);
	else
		self.PendingLabel:SetPoint("RIGHT", self.ExpirationTime, "RIGHT", -3, 0);
	end

	self.expiration = GetTime() + appDuration;

	local panel = self:GetParent():GetParent():GetParent();

	local id, activityID, name, comment, voiceChat, iLvl, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted = C_LFGList.GetSearchResultInfo(resultID);
	local activityName = C_LFGList.GetActivityInfo(activityID);

	self.resultID = resultID;
	self.Selected:SetShown(panel.selectedResult == resultID and not isApplication and not isDelisted);
	self.Highlight:SetShown(panel.selectedResult ~= resultID and not isApplication and not isDelisted);
	local nameColor = NORMAL_FONT_COLOR;
	local activityColor = GRAY_FONT_COLOR;
	if ( isDelisted or isAppFinished ) then
		nameColor = LFG_LIST_DELISTED_FONT_COLOR;
		activityColor = LFG_LIST_DELISTED_FONT_COLOR;
	elseif ( numBNetFriends > 0 or numCharFriends > 0 or numGuildMates > 0 ) then
		nameColor = BATTLENET_FONT_COLOR;
	elseif time() - age > PremadeFilter_Frame.updated then
		nameColor = LFG_LIST_FRESH_FONT_COLOR;
	end
	
	self.Name:SetWidth(0);
	self.Name:SetText(name);
	self.Name:SetTextColor(nameColor.r, nameColor.g, nameColor.b);
	self.ActivityName:SetText(activityName);
	self.ActivityName:SetTextColor(activityColor.r, activityColor.g, activityColor.b);
	self.VoiceChat:SetShown(voiceChat ~= "");
	self.VoiceChat.tooltip = voiceChat;

	local displayData = C_LFGList.GetSearchResultMemberCounts(resultID);
	LFGListGroupDataDisplay_Update(self.DataDisplay, activityID, displayData, isDelisted);

	local nameWidth = isApplication and 165 or 176;
	if ( voiceChat ~= "" ) then
		nameWidth = nameWidth - 22;
	end
	if ( self.Name:GetWidth() > nameWidth ) then
		self.Name:SetWidth(nameWidth);
	end
	self.ActivityName:SetWidth(nameWidth);

	local mouseFocus = GetMouseFocus();
	if ( mouseFocus == self ) then
		LFGListSearchEntry_OnEnter(self);
	end
	if ( mouseFocus == self.VoiceChat ) then
		mouseFocus:GetScript("OnEnter")(mouseFocus);
	end

	if ( isApplication ) then
		self:SetScript("OnUpdate", LFGListSearchEntry_UpdateExpiration);
		LFGListSearchEntry_UpdateExpiration(self);
	else
		self:SetScript("OnUpdate", nil);
	end
end

function LFGListUtil_SortSearchResultsCB(id1, id2)
	local id1, activityID1, name1, comment1, voiceChat1, iLvl1, age1, numBNetFriends1, numCharFriends1, numGuildMates1, isDelisted1, leaderName1, numMembers1 = C_LFGList.GetSearchResultInfo(id1);
	local id2, activityID2, name2, comment2, voiceChat2, iLvl2, age2, numBNetFriends2, numCharFriends2, numGuildMates2, isDelisted2, leaderName2, numMembers2 = C_LFGList.GetSearchResultInfo(id2);
	
	--If one has more friends, do that one first
	if ( numBNetFriends1 ~= numBNetFriends2 ) then
		return numBNetFriends1 > numBNetFriends2;
	end

	if ( numCharFriends1 ~= numCharFriends2 ) then
		return numCharFriends1 > numCharFriends2;
	end

	if ( numGuildMates1 ~= numGuildMates2 ) then
		return numGuildMates1 > numGuildMates2;
	end
	
	return age1 < age2;
end

function PremadeFilter_ParseQuery(searchText)
	local include = {};
	local exclude = {};
	local possible = {};
	
	if searchText ~= "" then
		local words = {}
		for w in searchText:gmatch("%S+") do table.insert(words, w) end
		
		for i,w in pairs(words) do
			local firstChar = w:sub(1,1);
			if firstChar == "+" then
				w = w:sub(2, w:len());
				if w ~= "" then
					table.insert(include, w);
				end
			elseif firstChar == "-" then
				w = w:sub(2, w:len());
				if w ~= "" then
					table.insert(exclude, w);
				end
			elseif firstChar == "?" then
				w = w:sub(2, w:len());
				if w ~= "" then
					table.insert(possible, w);
				end
			else
				table.insert(include, w);
			end
		end
	end
	
	return include, exclude, possible;
end

function PremadeFilter_IsStringMatched(str, include, exclude, possible)
	local matches = true;
	
	if next(include) ~= nil then
		for i,w in pairs(include) do
			local strMatch = str:find(w);
			if strMatch == nil then
				matches = false;
				break
			end
		end
	end
	
	if matches and next(exclude) ~= nil then
		for i,w in pairs(exclude) do
			local strMatch = str:find(w);
			if strMatch ~= nil then
				matches = false;
				break
			end
		end
	end
	
	if matches and next(possible) ~= nil then
		local strMatch = false;
		for i,w in pairs(possible) do
			local possibleMatch = str:find(w);
			if possibleMatch ~= nil then
				strMatch = true;
				break
			end
		end
		matches = matches and strMatch;
	end
	
	return matches;
end

function LFGListEntryCreation_ListGroup(self)
	local name = LFGListEntryCreation_GetSanitizedName(self);
	if ( LFGListEntryCreation_IsEditMode(self) ) then
		C_LFGList.UpdateListing(self.selectedActivity, name, tonumber(self.ItemLevel.EditBox:GetText()) or 0, self.VoiceChat.EditBox:GetText(), self.Description.EditBox:GetText());
		LFGListFrame_SetActivePanel(self:GetParent(), self:GetParent().ApplicationViewer);
	else
		local description = self.Description.EditBox:GetText();
		
		local tank = PremadeFilter_Roles.TankCheckButton:GetChecked();
		local heal = PremadeFilter_Roles.HealerCheckButton:GetChecked();
		local dps  = PremadeFilter_Roles.DamagerCheckButton:GetChecked();
		local roles = 0;
		
		if tank or heal or dps then
			if tank then roles = roles+4 end
			if heal then roles = roles+2 end
			if dps  then roles = roles+1 end
			
			description = description..string.char(194, 128+roles);
		end
		
		if(C_LFGList.CreateListing(self.selectedActivity, name, tonumber(self.ItemLevel.EditBox:GetText()) or 0, self.VoiceChat.EditBox:GetText(), description)) then
			self.WorkingCover:Show();
			LFGListEntryCreation_ClearFocus(self);
		end
	end
end

function PremadeFilter_CheckButtonSound(self)
	if ( self:GetChecked() ) then
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
end

function PremadeFilter_CheckButton_Editbox_OnClick(self)
	if ( self:GetChecked() ) then
		PlaySound("igMainMenuOptionCheckBoxOn");
		self:GetParent().EditBox:Show();
		self:GetParent().EditBox:SetFocus();
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
		self:GetParent().EditBox:Hide();
		self:GetParent().EditBox:ClearFocus();
		self:GetParent().EditBox:SetText("");
	end
end

function PremadeFilter_Experimental(self)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
	GameTooltip:SetText("EXPERIMENTAL:\nWorks only on premades created with Premade Filter addon.", nil, nil, nil, nil, true);
	GameTooltip:Show();
end
