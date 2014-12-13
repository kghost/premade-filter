function LFGListSearchPanel_DoSearch(self)
	local searchText = "";--self.SearchBox:GetText();
	C_LFGList.Search(self.categoryID, searchText, self.filters, self.preferredFilters);
	self.searching = true;
	self.searchFailed = false;
	self.selectedResult = nil;
	--print("LFGListSearchPanel_DoSearch");
	LFGListSearchPanel_UpdateResultList(self);
	LFGListSearchPanel_UpdateResults(self);
end

function LFGListSearchPanel_UpdateResultList(self)
	--print("LFGListSearchPanel_UpdateResultList");
	self.totalResults, self.results = C_LFGList.GetSearchResults();
	self.applications = C_LFGList.GetApplications();
	
	local searchText = self.SearchBox:GetText():lower();
	--print("QUERY: "..searchText);
	
	local words = {}
	for w in searchText:gmatch("%S+") do table.insert(words, w) end
	
	local include = {}
	local exclude = {}
	
	for i,w in pairs(words) do
		if w:sub(1,1) ~= "-" then
			table.insert(include, w)
			--print("INCLUDE: "..w);
		else
			w = w:sub(2, w:len());
			if w ~= "" then
				table.insert(exclude, w)
				--print("EXCLUDE: "..w);
			end
		end
	end
	
	if searchText ~= "" then
		local numResults = 0;
		local newResults = {};
		--print("LOOP");
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
				--print("MATCHED "..name)
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
