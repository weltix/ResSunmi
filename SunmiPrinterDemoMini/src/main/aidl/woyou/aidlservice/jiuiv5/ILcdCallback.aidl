package woyou.aidlservice.jiuiv5;

/**
 * Gu Xian feedback results.
 */
interface ILcdCallback {

	/**
	* Return execution result.
	* @param  show	 {@code true} - success, {@code false} - failure.
	*/
	oneway void onRunResult(boolean show);	
}