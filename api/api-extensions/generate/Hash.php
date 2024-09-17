<?php
	class Hash extends Extensions{
		public static function process($getParams, $postParams){
			if(isset($getParams['type'])){
 
 				switch ($getParams['type']) {
 					case 'md5':
 						$hash = md5($getParams['string']);
 						break;
 					default:
					 throw new Exception('Invalid hash type', 400);
 				}

				return array("hash" => $hash);
			}else{
				throw new Exception('Missing hash type', 400);
			}
		}	
	}
?>
