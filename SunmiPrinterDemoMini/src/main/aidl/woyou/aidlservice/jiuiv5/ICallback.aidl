package woyou.aidlservice.jiuiv5;

/**
 * Callback of print service execution results.
 */
interface ICallback {

	/**
	* Return the result of the interface execution.
	* Note: This callback only indicates whether the interface execution is successful, but does not
	* indicate the working result of the printer. If you need to obtain the printer result, please
	* use the transaction mode.
	*
	* @param  isSuccess   {@code true} - execution succeeded, {@code false} - execution failed.
	*/
	oneway void onRunResult(boolean isSuccess);

	/**
	* Returns the result of the interface execution (string data).
	*
	* @param  result 	as a result, the print length, etc. since the printer was powered on (in mm)
	*/
	oneway void onReturnString(String result);

	/**
	* Returns the specific cause of an exception when the interface fails to execute.
	*
	* @param  code 	Exception code.
	* @param  msg 	Exception description.
	*/
	oneway void onRaiseException(int code, String msg);

	/**
	* Return to printer results.
	*
	* @param  code 	Exception code, {@code 0} - success, {@code 1} - failure.
	* @param  msg 	Exception description.
	*/
	oneway void onPrintResult(int code, String msg);
	
}