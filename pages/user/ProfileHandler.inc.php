<?php

/**
 * ProfileHandler.inc.php
 *
 * Copyright (c) 2003-2004 The Public Knowledge Project
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @package pages.user
 *
 * Handle requests for modifying user profiles. 
 *
 * $Id$
 */

class ProfileHandler extends UserHandler {
	
	/**
	 * Display form to edit user's profile.
	 */
	function profile() {
		parent::validate();
		parent::setupTemplate(true);
		
		import('user.form.ProfileForm');
		
		$profileForm = &new ProfileForm();
		$profileForm->initData();
		$profileForm->display();
	}
	
	/**
	 * Validate and save changes to user's profile.
	 */
	function saveProfile() {
		parent::validate();
		
		import('user.form.ProfileForm');
		
		$profileForm = &new ProfileForm();
		$profileForm->readInputData();
		
		if ($profileForm->validate()) {
			$profileForm->execute();
			Request::redirect('user');
			
		} else {
			parent::setupTemplate(true);
			$profileForm->display();
		}
	}
	
}

?>
