<?php
	
	global $wpdb;
	global $S_CLIENT_ID;
	global $S_CLIENT_SECRET;
	
	$usr_code=$_GET['code']; //Strava callback sets this

	if (!empty($usr_code)) {
		$req_type="newathlete";
	} else {
		$req_type=$_GET['reqtype'];
	}
	
	switch ($req_type) {
		case "newathlete":
			//new user authenticating since Strava query param 'code' exists
			//echo "<p>usr_code EXISTS and is {$usr_code}</p>";
			$curlcall="curl -X POST https://www.strava.com/oauth/token -F client_id=".$S_CLIENT_ID." -F client_secret=".$S_CLIENT_SECRET." -F code=".$usr_code;

			echo "<p>{$curlcall} <<<< that is the CURLCALL variable to execute </p>";
			
			$output2= shell_exec($curlcall);
		
			$ins_result= $wpdb->insert( 
							's_join', 
							array( 
								'usercode' => $usr_code, 
								'authresult' => $output2,
								'id' =>  0
								  ), 
							array( 
								'%s', 
								'%s',
								'%d'
								  )
							);
			echo("We will post your analysis ASAP!"); 
			break;
		case "updrequest":
			// existing athlete requesting new analysis
			$pagetitle=$_GET['athleteid'];
			//echo "<p>usr_code DOES NOT EXIST and pagetitle is {$pagetitle} $pagetitle pagetitle</p>";
		
			$ins_result= $wpdb->insert( 
								   's_join', 
								   array( 
										 'usercode' => $pagetitle, 
										 'authresult' => 'REPROCESS',
										 'id' =>  0
										 ), 
								   array( 
										 '%s', 
										 '%s',
										 '%d'
										 ) 
								   );
			echo("We will post your analysis ASAP!"); 
			break;
		case "updanalysis":
		
			//////
			$JSONdata='[["kom","2nd","3nd","4th","5th","6th","7th","8th","9th","10th"],["13","4","2","7","3","3","5","3","1","1"]]';
			$TABLEPRESSTABLE='analysis02-3414968.out';
		
			$result=$wpdb->update( 
							  'wp_posts', 
							  array( 
									'post_content' => $JSONdata
									), 
							  array(
									'post_title' => $TABLEPRESSTABLE
									),
							  array( 
									'%s'
									)
							  );
			//////
		
			echo "<p>{$result} ROWS UPDATED</p>";
			break;
		default:
			// didn't get proper parameters
		
	}
	
?>
