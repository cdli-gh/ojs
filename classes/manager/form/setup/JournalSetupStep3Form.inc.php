<?php

/**
 * JournalSetupStep3Form.inc.php
 *
 * Copyright (c) 2003-2004 The Public Knowledge Project
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @package manager.form.setup
 *
 * Form for Step 3 of journal setup.
 *
 * $Id$
 */

import("manager.form.setup.JournalSetupForm");

class JournalSetupStep3Form extends JournalSetupForm {
	
	function JournalSetupStep3Form() {
		parent::JournalSetupForm(
			3,
			array(
				'authorGuidelines' => 'string',
				'bibFormat' => 'string',
				'copyrightNotice' => 'string'
			)
		);
	}
	
}

?>
