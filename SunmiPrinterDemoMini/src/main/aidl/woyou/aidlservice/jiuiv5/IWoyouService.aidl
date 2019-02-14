/**
* JIUI T1mini Print service
* AIDL Version: 2.1
*/

package woyou.aidlservice.jiuiv5;

import woyou.aidlservice.jiuiv5.ICallback;
import woyou.aidlservice.jiuiv5.ILcdCallback;
import android.graphics.Bitmap;
import woyou.aidlservice.jiuiv5.ITax;

interface IWoyouService
{
	/**
	* Printer firmware upgrade (only for system component calls, developer calls are invalid).
	*
	* @param buffer
	* @param size
	* @param filename
	* @param iapInterface
	*/
	void updateFirmware();

	/**
	* Printer firmware status.
	*
	* @return   {@code 0} - unknown, {@code A5} - bootloader, {@code C3} - print.
	*/
	int getFirmwareStatus();

	/**
	* Get the WoyouService service version.
	*/
	String getServiceVersion();

	/**
	 * Initialize the printer, reset the printer's logic, but not clear the buffer data, so
	 * incomplete print jobs will continue after reset.
	 *
	 * @param callback   Callback.
	 * @return
	 */
	void printerInit(in ICallback callback);

	/**
	* The printer self-test, the printer will print a self-test page.
	*
	* @param callback   Callback.
	*/
	void printerSelfChecking(in ICallback callback);

	/**
	* Get the printer board serial number.
	*/
	String getPrinterSerialNo();

	/**
	* Get the printer firmware version number.
	*/
	String getPrinterVersion();

	/**
	* Get the printer model.
	*/
	String getPrinterModal();

	/**
	* Get printhead print length.
	*/
	int getPrintedLength();

	/**
	 * The printer feeds paper (forced line feed, after the end of the print content,
	 * the paper is n lines).
	 *
	 * @param  n	     number of lines.
	 * @param  callback  result callback.
	 * @return
	 */
	void lineWrap(int n, in ICallback callback);

	/**
	* Print using the original instructions.
	*
	* @param  data	     instruction.
	* @param  callback   result callback.
	*/
	void sendRAWData(in byte[] data, in ICallback callback);

	/**
	* Set the alignment mode to have an effect on subsequent printing unless initialized.
	*
	* @param  alignment  {@code 0} - left, {@code 1} - centered, {@code 2} - right.
	* @param  callback   result callback.
	*/
	void setAlignment(int alignment, in ICallback callback);

	/**
	* Set the print font to have an effect on the print afterwards, unless initialized.
	* (Currently only one font "gh" is supported, gh is a monospaced Chinese font, and more font
	* options will be provided later).
	*
	* @param  typeface	 font name.
	*/
	void setFontName(String typeface, in ICallback callback);

	/**
	* Set the font size, which has an effect on printing afterwards, unless initialized.
	* Note: The font size is printed beyond the standard international directives.
	* Adjusting the font size will affect the character width,
	* and the number of characters per line will also change.
	* Therefore, the layout formed by the monospaced font may be confusing.
	*
	* @param  fontsize   font size.
	*/
	void setFontSize(float fontsize, in ICallback callback);

	/**
	* Print text, the text width is full of one line, and it is automatically wrapped and typeset.
	* If it is not full, it will not print unless it is forced to wrap.
	*
	* @param  text   the text string to be printed.
	*/
	void printText(String text, in ICallback callback);

	/**
	* Print the text of the specified font, the font setting is only valid for this time.
	*
	* @param  text 			to print text.
	* @param  typeface 		font name (currently only supports "gh" font).
	* @param  fontsize 		font size.
	*/
	void printTextWithFont(String text, String typeface, float fontsize, in ICallback callback);

	/**
	* Print a row of the table, you can specify the column width, alignment.
	*
	* @param  colsTextArr   array of text strings for each column.
	* @param  colsWidthArr  array of column widths (in English characters,
	*                       each Chinese character occupies two English characters,
	*                       each width is greater than 0).
	* @param  colsAlign	    alignment of columns
	*                       ({@code 0} - left, {@code 1} - center, {@code 2} - right).
    *
    * Note: The array length of the three parameters should be the same.
    * If the width of colsText[i] is greater than colsWidth[i], the text is wrapped.
	*/
	void printColumnsText(in String[] colsTextArr, in int[] colsWidthArr, in int[] colsAlign, in ICallback callback);


	/**
	* Print picture.
	* @param  bitmap 	image bitmap object
	*                   (maximum width 384 pixels, more than unprintable and
	*                   callback - callback exception function).
	*/
	void printBitmap(in Bitmap bitmap, in ICallback callback);

	/**
	* Print one-dimensional barcode.
	*
	* @param  data         bar code data
	* @param  symbology    barcode type
	*    0 -- UPC-A，
	*    1 -- UPC-E，
	*    2 -- JAN13(EAN13)，
	*    3 -- JAN8(EAN8)，
	*    4 -- CODE39，
	*    5 -- ITF，
	*    6 -- CODABAR，
	*    7 -- CODE93，
	*    8 -- CODE128
	* @param  height  		bar code height, from {@code 1} to {@code 255}, default {@code 162}.
	* @param  width  		bar code width, value {@code 2} to {@code 6}, default {@code 2}.
	* @param  textposition 	text position
	*                       {@code 0} - Do not print text,
	*                       {@code 1} - Text is above the barcode,
	*                       {@code 2} - Text is below the barcode,
	*                       {@code 3} - Barcode is printed above and below.
	*/
	void printBarCode(String data, int symbology, int height, int width, int textposition,  in ICallback callback);

	/**
	* Print 2D barcode.
	*
	* @param  data 			QR code data.
	* @param  modulesize 	Two-dimensional code block size (unit: point, value {@code 1} to {@code 16}).
	* @param  errorlevel 	QR code error correction level ({@code 0} to {@code 3}).
	*                       {@code 0} - Error correction level L ({@code 7%})，
	*                       {@code 1} - Error correction level M ({@code 15%})，
	*                       {@code 2} - Error correction level Q ({@code 25%})，
	*                       {@code 3} - Error correction level H ({@code 30%}).
	*/
	void printQRCode(String data, int modulesize, int errorlevel, in ICallback callback);

	/**
	* Print text, the text width is full of one line, and it is automatically wrapped and typeset.
	* If it is not full, it will not print unless it is forced to wrap.
	* The text is output as it is in the width of the vector text, that is,
	* each character is not equal in width.
	*
	* @param  text  	the text string to be printed.
	*
	* Increased in Ver 1.7.6
	*/
	void printOriginalText(String text, in ICallback callback);

	/**
	* Print buffer content.
	*/
	void commitPrinterBuffer();

	/**
	* Cut paper.
	*/
	void cutPaper(in ICallback callback);

	/**
	* Get the number of cutters.
	*/
	int getCutPaperTimes();

	/**
	* Open the cashbox.
	*/
	void openDrawer(in ICallback callback);

	/**
	* Cash drawer cumulative opening times.
	*/
	int getOpenDrawerTimes();

	/**
	* Enter buffer mode, all print calls will be cached, print after calling promisePrinterBuffer().
	*
	* @param  clean   whether to clear the buffer contents.
	*/
	void enterPrinterBuffer(in boolean clean);

	/**
	* Exit buffer mode.
	*
	* @param  commit   whether to print out the contents of the buffer.
	*/
	void exitPrinterBuffer(in boolean commit);

	void tax(in byte [] data,in ITax callback);

	// Get the current printer mode: {@code 0} - normal mode, {@code 1} - black mark mode.
	int getPrinterMode();

	// Get the black paper mode printer automatic paper distance.
	int getPrinterBBMDistance();

	/**
	* Print a row of the table, you can specify the column width, alignment.
	*
	* @param  colsTextArr    array of text strings for each column.
	* @param  colsWidthArr   the weight of each column is the proportion of each column.
	* @param  colsAlign	     alignment of columns ({@code 0} - left, {@code 1} - center, {@code 2} - right).
	*
	* Note: The array length of the three parameters should be the same.
	* If the width of colsText[i] is greater than colsWidth[i], the text is wrapped.
	*/
	void printColumnsString(in String[] colsTextArr, in int[] colsWidthArr, in int[] colsAlign, in ICallback callback);

	/**
	* Get the latest status of the printer.
	*
	* @return  {@code 1} - printer is OK.
	*          {@code 2} - printer update status.
    *          {@code 3} - get status error.
    *          {@code 4} - out of paper.
    *          {@code 5} - overheat.
    *          {@code 6} - open cover.
    *          {@code 7} - cutter abnormality.
    *          {@code 8} - cutter recovery.
    *          {@code 505} -no printer detected.
	**/
	int updatePrinterState();

	/*
	* @param  flag  {@code 1} - initialization.
	*               {@code 2} - wake up LCD.
    *               {@code 3} - sleep LCD.
    *               {@code 4} - clear screen.
	*/
	void sendLCDCommand(in int flag);

	void sendLCDString(in String string, ILcdCallback callback);

	void sendLCDBitmap(in Bitmap bitmap, ILcdCallback callback);

		/**
    	* With feedback print buffer content.
    	*
    	* @param  callback  feedback.
       	*/
    	void commitPrinterBufferWithCallback(in ICallback callback);

    	/**
    	* With feedback exit buffer print mode.
    	*
    	* @param  commit    whether to submit the buffer content.
    	* @param  callback  feedback.
    	*/
    	void exitPrinterBufferWithCallback(in boolean commit, in ICallback callback);

        /**
        * Output string with size to LCD.
        *
        * @param  string    the string content displayed on the LCD, each string array will be
        *                   displayed with the specified position size.
        * @param  size  0:invaild
        *               1:4(1-4)
        *               2:3(1-3)
        *               3:3(2-4)
        *               4:2(1-2)
        *               5:2(2-3)
        *               6:2(3-4)
        *               7:1(1)
        *               8:2(2)
        *               9:3(3)
        *               10:4(4)
        */
    	void sendLCDDoubleString(in String topText, in String bottomText, ILcdCallback callback);

        /**
        * Print picture.
        *
        * @param  bitmap  	 image bitmap object (maximum width 384 pixels, pictures over 1M cannot be printed)
        * @param  type       there are currently two printing methods:
        *                    {@code 0} - the same printBitmap,
        *                    {@code 1} - the threshold of 200 black and white pictures,
        *                    {@code 2} - grayscale pictures.
        */
        void printBitmapCustom(in Bitmap bitmap, in int type, in ICallback callback);
}