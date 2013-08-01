package
{
	import mx.collections.ArrayCollection;

	public class MasterDetailCodegen
	{
		public function MsdtSP(pojoMaster:String,pojoDetail:String,acMs:ArrayCollection,acDt:ArrayCollection,keyMs:ArrayCollection,keyDt:ArrayCollection ):String {
			
			pojoMaster = pojoMaster.charAt(0).toUpperCase() + pojoMaster.slice(1);
			pojoDetail = pojoDetail.charAt(0).toUpperCase() + pojoDetail.slice(1);
			
		 var sp:String = '';
		 sp += "-- spMsdt_"+pojoMaster+"_"+pojoDetail+"_getMsdt(_userid,_idx); \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_getMsdt`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_getMsdt`(_userid varchar(30),`_idx` varchar(30)) \n" + 
		 "BEGIN \n" + 
		 "IF (`_idx` = '' OR ISNULL(`_idx`))  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "    -- check auth\n" + 
		 "	SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "   	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN\n" + 
		 "            -- query-- \n" + 
		 "            select * from "+pojoMaster+" where  idx = _idx; \n" + 
		 "            select * from "+pojoDetail+" where  idx = _idx; \n" + 
		 "            -- insert loging \n" + 
		 "           	call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "        ELSE \n" + 
		 "            call getErrorMsg(60007);   \n" + 
		 "        END IF; -- IF @TF   \n" + 
		 "    ELSE \n" + 
		 "        call getErrorMsg(40001); -- not authoirz   \n" + 
		 "    END IF; -- IF @auth   \n" + 
		 "END IF; -- validate \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ;   \n" + 
		 " \n" + 
		 " \n" + 
		 "--   spMsdt_"+pojoMaster+"_"+pojoDetail+"_getAllMs(_userid) \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_getAllMs`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_getAllMs`(_userid varchar(30)) \n" + 
		 "BEGIN \n" + 
		 "IF (`_userid` = '' OR ISNULL(`_userid`))  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "    -- check auth\n" + 
		 "	SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "    	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN\n" + 
		 "            -- query-- \n" + 
		 "            select * from "+pojoMaster+"; \n" + 
		 "            -- insert loging \n" + 
		 "            call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "         END IF; -- Control doc \n" + 
		 "    END IF; -- auth \n" + 
		 "END IF; -- validate \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ;   \n" + 
		 " \n" + 
		 " \n" + 
		 "-- spMsdt_"+pojoMaster+"_"+pojoDetail+"_getAllDtbyID(_userid,_idx); \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_getAllDtbyID`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_getAllDtbyID`(_userid varchar(30),_idx varchar(30)) \n" + 
		 "BEGIN \n" + 
		 "IF (`_userid` = '' OR ISNULL(`_userid`)) OR ( _idx = '' or ISNULL(_idx) )  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "    -- check auth\n" + 
		 "	SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "    	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN   \n" + 
		 "            -- query-- \n" + 
		 "            select * from "+pojoDetail+" where 1=1 and idx= _idx; \n" + 
		 "            -- insert loging \n" + 
		 "            call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "        ELSE \n" + 
		 "            call getErrorMsg(60007);   \n" + 
		 "        END IF; -- IF @TF   \n" + 
		 "    ELSE \n" + 
		 "        call getErrorMsg(40001); -- not authoirz   \n" + 
		 "    END IF; -- IF @auth   \n" + 
		 "END IF; -- validate \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ; \n" + 
		 " \n" + 
		 " \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_UpdateMs`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_UpdateMs`(_userid varchar(30),_idx varchar(30),_name varchar(30),_docDate varchar(30),_total varchar(30)) \n" + 
		 "BEGIN \n" + 
		 "IF `_userid` = '' OR ISNULL(`_userid`)  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "    -- check auth\n" + 
		 "	SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "    	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN     -- query-- \n" + 
		 "            START TRANSACTION; \n" + 
		 "            UPDATE "+pojoMaster+" SET name= _name, docDate= _DocDate, total= _total where 1= 1  and idx = _idx; \n" + 
		 "            COMMIT; \n" + 
		 "            -- insert loging \n" + 
		 "            call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "        ELSE \n" + 
		 "            call getErrorMsg(60007); \n" + 
		 "        END IF; -- IF @TF \n" + 
		 "    ELSE \n" + 
		 "        call getErrorMsg(40001); -- not authoirz   \n" + 
		 "    END IF; -- IF @auth   \n" + 
		 "END IF; -- validate \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ; \n" + 
		 " \n" + 
		 " \n" + 
		 "-- spMsdt_"+pojoMaster+"_"+pojoDetail+"_UpdateDt(_userid,_idx,_idNo,_desc,_qty); \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_UpdateDt`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_UpdateDt`(_userid varchar(30),_idx varchar(30),_idNo varchar(30) ) \n" + 
		 "BEGIN \n" + 
		 "IF (`_userid` = '' OR ISNULL(`_userid`))  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "    -- check auth\n" + 
		 "	SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "    	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN   \n" + 
		 "	     -- query-- \n" + 
		 "            START TRANSACTION; \n" + 
		 "              UPDATE "+pojoDetail+" SET `desc` = _desc, qty= _qty where 1=1  and idx = _idx and _idNo = _idNo; \n" + 
		 "            COMMIT; \n" + 
		 "            -- insert loging \n" + 
		 "            call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "        ELSE \n" + 
		 "            call getErrorMsg(60007);   \n" + 
		 "        END IF; -- IF @TF   \n" + 
		 "    ELSE \n" + 
		 "        call getErrorMsg(40001); -- not authoirz   \n" + 
		 "    END IF; -- IF @auth   \n" + 
		 "END IF; -- validate \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ; \n" + 
		 " \n" + 
		 " \n" + 
		 "-- spMsdt_"+pojoMaster+"_"+pojoDetail+"_voidMs(_userid,_idx); \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_voidMs`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_voidMs`(_userid varchar(30)) \n" + 
		 "BEGIN \n" + 
		 "IF (`_userid` = '' OR ISNULL(`_userid`))  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "    -- check auth\n" + 
		 "	SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "    	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN     -- query-- \n" + 
		 "            START TRANSACTION; \n" + 
		 "            delete from "+pojoDetail+" where  idx = idx  ; \n" + 
		 "            update "+pojoMaster+" set status = 'I'  where 1=1  and idx = _idx; \n" + 
		 "            COMMIT; \n" + 
		 "            -- insert loging \n" + 
		 "            call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "        ELSE \n" + 
		 "            call getErrorMsg(60007);\n" +     
		 "        END IF; -- IF @TF\n" +    
		 "    ELSE \n" + 
		 "        call getErrorMsg(40001); -- not authoirz   \n" + 
		 "    END IF; -- IF @auth   \n" + 
		 "END IF; -- validate \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ; \n" + 
		 "  \n" + 
		 " \n" + 
		 "-- spMsdt_"+pojoMaster+"_"+pojoDetail+"_delMsdt(_userid,_idx); \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_delMsdt`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_delMsdt`(_userid varchar(30)) \n" + 
		 "BEGIN \n" + 
		 "IF (`_userid` = '' OR ISNULL(`_userid`))  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "    -- check auth\n" + 
		 "	SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "    	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN \n" + 
		 "	     -- query-- \n" + 
		 "            START TRANSACTION; \n" + 
		 "            delete from "+pojoDetail+"  where 1=1  and idx = _idx; \n" + 
		 "            delete from "+pojoMaster+"  where 1=1   and idx = _idx; \n" + 
		 "            COMMIT; \n" + 
		 "            -- insert loging \n" + 
		 "            call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "        ELSE \n" + 
		 "            call getErrorMsg(60007);   \n" + 
		 "        END IF; -- IF @TF   \n" + 
		 "    ELSE \n" + 
		 "        call getErrorMsg(40001); -- not authoirz   \n" + 
		 "    END IF; -- IF @auth   \n" + 
		 "END IF; -- validate \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ; \n" + 
		 " \n" + 
		 " \n" + 
		 "-- spMsdt_"+pojoMaster+"_"+pojoDetail+"_delDtitem(_userid,_idx,_idNo); \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_delDtitem`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_delDtitem`(_userid varchar(30)) \n" + 
		 "BEGIN \n" + 
		 "IF (`_userid` = '' OR ISNULL(`_userid`))  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "    -- check auth\n" + 
		 "	SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "    	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN   \n" + 
		 "	     -- query-- \n" + 
		 "            START TRANSACTION; \n" + 
		 "            delete from "+pojoDetail+"  where 1=1  and idx = _idx and idNo = _idNo; \n" + 
		 "            COMMIT; \n" + 
		 "            -- insert loging \n" + 
		 "            call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "        ELSE \n" + 
		 "            call getErrorMsg(60007);   \n" + 
		 "        END IF; -- IF @TF   \n" + 
		 "    ELSE \n" + 
		 "        call getErrorMsg(40001); -- not authoirz   \n" + 
		 "    END IF; -- IF @auth   \n" + 
		 "END IF; -- validate \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ; \n" + 
		 " \n" + 
		 "\n" +  
		 "-- spMsdt_"+pojoMaster+"_"+pojoDetail+"_getDtItem(_userid,_idx,_idNo); \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_getDtItem`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_getDtItem`(_userid varchar(30)) \n" + 
		 "BEGIN \n" + 
		 "IF (`_userid` = '' OR ISNULL(`_userid`))  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "    -- check auth\n" + 
		 "	SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "    	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN   \n" + 
		 "            -- query-- \n" + 
		 "            select * from "+pojoDetail+" where 1=1  and idx = _idx and idNo = _idNo; \n" + 
		 "            -- insert loging \n" + 
		 "            call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "        ELSE \n" + 
		 "            call getErrorMsg(60007);   \n" + 
		 "        END IF; -- IF @TF   \n" + 
		 "    ELSE \n" + 
		 "        call getErrorMsg(40001); -- not authoirz   \n" + 
		 "    END IF; -- IF @auth   \n" + 
		 "END IF; -- validate \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ; \n" + 
		 "   \n" + 
		 "-- spMsdt_"+pojoMaster+"_"+pojoDetail+"_InsertMs(_userid,_idx,_name,_docDate,_total); \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_InsertMs`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_InsertMs`(_userid varchar(30)) \n" + 
		 "BEGIN \n" + 
		 "IF (`_userid` = '' OR ISNULL(`_userid`))  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "    -- check auth\n" + 
		 "	SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "    	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN\n" + 
		 "            -- query-- \n" + 
		 "            START TRANSACTION; \n" + 
		 "            Insert Into "+pojoMaster+" ( idx, name, docDate, total ) values ( _idx, _name, _docDate, _total); \n" + 
		 "            COMMIT; \n" + 
		 "            -- insert loging \n" + 
		 "            call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "        ELSE \n" + 
		 "            call getErrorMsg(60007);   \n" + 
		 "        END IF; -- IF @TF   \n" + 
		 "    ELSE \n" + 
		 "        call getErrorMsg(40001); -- not authoirz   \n" + 
		 "    END IF; -- IF @auth   \n" + 
		 "END IF; -- validate \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ; \n" + 
		 " \n" + 
		 "-- spMsdt_"+pojoMaster+"_"+pojoDetail+"_InsertDt(_userid,_idx,_idNo,_desc,_qty); \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_InsertDt`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_InsertDt`(_userid varchar(30)) \n" + 
		 "BEGIN \n" + 
		 "IF (`_userid` = '' OR ISNULL(`_userid`))  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "	-- check auth\n" + 
		 "	SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "    	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN\n" + 
		 "            -- query-- \n" + 
		 "            START TRANSACTION; \n" + 
		 "            Insert Into "+pojoDetail+"(`idx`, `idNo`, `desc`, `qty`) values (_idx, _idNo, _desc, _qty); \n" + 
		 "            COMMIT; \n" + 
		 "            -- insert loging \n" + 
		 "            call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "        ELSE \n" + 
		 "            call getErrorMsg(60007);   \n" + 
		 "        END IF; -- IF @TF   \n" + 
		 "    ELSE \n" + 
		 "        call getErrorMsg(40001); -- not authoirz   \n" + 
		 "    END IF; -- IF @auth   \n" + 
		 "END IF; -- validate \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ; \n" + 
		 "  \n" + 
		 " \n" + 
		 "-- spMsdt_"+pojoMaster+"_"+pojoDetail+"_getLast(_userid); \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_getLast`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_getLast`(_userid varchar(30)) \n" + 
		 "BEGIN \n" + 
		 "IF (`_userid` = '' OR ISNULL(`_userid`))  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "    -- check auth\n" + 
		 "	SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "    	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN\n" + 
		 "            -- query-- \n" + 
		 "            select idx into @masterid from "+pojoMaster+" ORDER BY idx DESC limit 1 ;\n" + 
		 "	     select * from "+pojoMaster+" where 1=1 and idx = @masterid; \n" + 
		 "            select * from "+pojoDetail+" where 1=1 and idx = @masterid; \n" + 
		 "            -- insert loging \n" + 
		 "            call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "        ELSE \n" + 
		 "            call getErrorMsg(60007);   \n" + 
		 "        END IF; -- IF @TF   \n" + 
		 "    ELSE \n" + 
		 "        call getErrorMsg(40001); -- not authoirz   \n" + 
		 "    END IF; -- IF @auth   \n" + 
		 "END IF; -- validate \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ; \n" + 
		 "\n" + 
		 "\n" + 
		 "-- spMsdt_"+pojoMaster+"_"+pojoDetail+"_getMsdtforUpdate(_userid,_docNo,_"+pojoMaster+",_"+pojoDetail+"); \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_getMsdtforUpdate`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_getMsdtforUpdate`(_userid varchar(30),_idx varchar(30)) \n" + 
		 "BEGIN \n" + 
		 "IF (`_userid` = '' OR ISNULL(`_userid`))  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "    -- check auth\n" + 
		 "	SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "    	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN \n" + 
		 "            -- query-- \n" + 
		 "            select * from "+pojoMaster+" where idx = _idx; \n" + 
		 "            select * from "+pojoDetail+" where idx = _idx;   \n" + 
		 "            -- select fcControlUpdateTable(`_userid`,`_DocNo`,_"+pojoMaster+",_"+pojoDetail+"); \n" + 
		 "            -- insert loging \n" + 
		 "            call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "        ELSE \n" + 
		 "            call getErrorMsg(60007);   \n" + 
		 "        END IF; -- IF @TF   \n" + 
		 "    ELSE \n" + 
		 "        call getErrorMsg(40001); -- not authoirz   \n" + 
		 "    END IF; -- IF @auth   \n" + 
		 "END IF; -- validate \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ; \n" + 
		 "  \n" + 
		 "-- spMsdt_"+pojoMaster+"_"+pojoDetail+"_CompleteSessionforUpdate() \n" + 
		 "DROP PROCEDURE IF EXISTS `spMsdt_"+pojoMaster+"_"+pojoDetail+"_CompleteSessionforUpdate`; \n" + 
		 "DELIMITER ;; \n" + 
		 "CREATE  PROCEDURE `spMsdt_"+pojoMaster+"_"+pojoDetail+"_CompleteSessionforUpdate`(_userid varchar(30)) \n" + 
		 "BEGIN \n" + 
		 "IF (`_userid` = '' OR ISNULL(`_userid`))  THEN \n" + 
		 "    call  getErrMsg(60007);	 \n" + 
		 "ELSE \n" + 
		 "    -- check auth\n" + 
		 "SET @auth = spAuthroize_usrid_module_func(_userid,'"+pojoMaster+"','GET'); \n" + 
		 "	IF @auth = 1 THEN \n" + 
		 "    	--  check SESSION \n" + 
		 "    	SET @TF = fcCtrlUpdateTableSingle(_userid,`_idx`,'"+pojoMaster+"'); \n" + 
		 "    	IF @TF = 1 THEN\n" + 
		 "            -- query-- \n" + 
		 "            -- fcCompleteUpdateTable(_userid,_module)   \n" + 
		 "            -- insert loging \n" + 
		 "            call sp_InsertLog('GET',_userid,@sql,@rownum,'"+pojoMaster+"'); \n" + 
		 "        ELSE \n" + 
		 "            call getErrorMsg(60007);   \n" + 
		 "        END IF; -- IF @TF   \n" + 
		 "    ELSE \n" + 
		 "        call getErrorMsg(40001); -- not authoirz   \n" + 
		 "    END IF; -- IF @auth   \n" + 
		 "END IF; \n" + 
		 "END \n" + 
		 ";; \n" + 
		 "DELIMITER ; \n" + 
		 "\n";
		 return sp;
		}
		
		
		public function Msdt(pojoMaster:String,pojoDetail:String,acMs:ArrayCollection,acDt:ArrayCollection,keyMs:ArrayCollection,keyDt:ArrayCollection ):String {
		var php:String = '';

		var paraMaster:String='';
		var bindMaster:String= '';
		
		var paraDetail:String='';
		var bindDetail:String= '';

		var phpKeyDetail:String = '';
		var keyDetail:String = '';
		var bindKeyDetail:String = '';
		var phpkeyMaster:String = '';
		var keyMaster:String = '';
		var bindKeyMaster:String = '';
		
		var pmaster:String = '';
		var pdetail:String = '';
		
		var srvName:String = pojoMaster+pojoDetail+"Service";
		pojoMaster = pojoMaster.charAt(0).toUpperCase() + pojoMaster.slice(1);
		pojoDetail = pojoDetail.charAt(0).toUpperCase() + pojoDetail.slice(1);
		srvName = srvName.charAt(0).toUpperCase() + srvName.slice(1);
		
		var i:int = 0;
		for (i = 0; i < acMs.length; i++) 
		{
			pmaster += "	public $"+ acMs[i].Field + ";\n";
			bindMaster += "        $stmt->bindParam('"+ acMs[i].Field +"', $Master->"+acMs[i].Field+");  \n";
			paraMaster += ":"+acMs[i].Field;
			if(i<acMs.length-1){
				paraMaster += ",";
			}
		}

		
		for (i = 0; i < acDt.length; i++) 
		{
			pdetail += "	public $"+acDt[i].Field+";\n";
			bindDetail += "        $stmt->bindParam('"+ acDt[i].Field +"', $Detail->"+acDt[i].Field+");  \n";
			paraDetail += ":"+acDt[i].Field;
			if(i<acDt.length-1){
				paraDetail += ",";
			}
		}
		
		for (i = 0; i < keyMs.length; i++) 
		{
			phpkeyMaster +="$"+keyMs[i].label;
			keyMaster += ":"+keyMs[i].label;
			if(i < keyMs.length-1){
				keyMaster += ",";
				phpkeyMaster += ",";
			}
			bindKeyMaster += "        $stmt->bindParam('"+ keyMs[i].label +"',$"+keyMs[i].label +");  \n";
			
		}
		
		for (i = 0; i < keyDt.length; i++) 
		{
			bindKeyDetail += "        $stmt->bindParam('"+ keyDt[i].Field +"', $"+ keyDt[i].Field+");  \n";
			phpKeyDetail += "$"+keyDt[i].Field;
			keyDetail += ":"+keyDt[i].Field;
			if(i<keyDt.length-1){
				phpKeyDetail += ",";
				keyDetail += ",";
			}
		}
		
		
		
	 php += "<?php  \n" + 
	     "require_once 'Pdoconfig.php';  \n" + 
	     "  \n" + 
	     "/*  \n" + 
	     "//--- TEST -----  \n" + 
	     "$tms = new "+ pojoMaster+pojoDetail+"Service();  \n" + 
	     "$res = $tms->getLastMasterDetail();  \n" + 
	     "//var_dump($res);  \n" + 
	     "echo json_encode($res);  \n" + 
	     "*/  \n" + 
	     "  \n" + 
	     "class "+ srvName +"\n" + 
	     "{  \n" + 
	     "    private $connection = null;  \n" + 
	     "    public function __construct()  \n" + 
	     "    {  \n" + 
	     "        global $option;  \n" + 
	     "        $this->connection = new PDO(\"mysql:host=\" . Pdoconfig::$server . \"; port=\" .  \n" + 
	  	 "            Pdoconfig::$port . \"; dbname=\" . Pdoconfig::$databasename, Pdoconfig::$username,  \n" + 
	     "            Pdoconfig::$password, array(PDO::MYSQL_ATTR_INIT_COMMAND => \"SET NAMES utf8\"));  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "    // get by ID  \n" + 
	     "    // @result  Master & Detail[]  \n" + 
	     "    // @param $idx = index of Master  \n" + 
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_getMsdt()  \n" + 
	     "    public function get"+ pojoMaster+pojoDetail +"($userid,"+phpkeyMaster+")  \n" + 
	     "    {  \n" + 
	     "        $stmt = $this->connection->prepare(\" call spMsdt_"+pojoMaster+"_"+pojoDetail+"_getMsdt(:userid,"+keyMaster+");\");  \n" + 
		 "        $stmt->bindParam('userid', $userid);  \n" + 
		 bindKeyMaster +
	     "    	if($stmt->execute()) {  \n" + 
	     "            $result = new MasDetail"+ pojoMaster +pojoDetail+"();  \n" + 
	     "            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);  \n" + 
	     "            $rows = Pdoconfig::prepareForAMF($rows,array(0 => '"+ pojoMaster +"'));  \n" + 
	     "            $result->master = $rows;  \n" + 
	     "            $stmt->nextRowset();  \n" + 
	     "            $rows1 = $stmt->fetchAll(\PDO::FETCH_ASSOC);  \n" + 
	     "    		$rows1 = Pdoconfig::prepareForAMF($rows1,array(0 => '"+pojoDetail+"'));  \n" + 
	     "            $result->detail = $rows1;  \n" + 
	     "    	} else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "    	return $result;  \n" + 
	     "    }   \n" + 
	     "  \n" + 
	     "    // get Master All  \n" + 
	     "    // @result  Master  \n" + 
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_getAllMs()  \n" + 
	     "    public function getAll"+ pojoMaster +"($userid)  \n" + 
	     "    {  \n" + 
	     "        $stmt = $this->connection->prepare(\"call  spMsdt_"+pojoMaster+"_"+pojoDetail+"_getAllMs(:userid);\");  \n" + 
		 "        $stmt->bindParam('userid', $userid);  \n" + 
	     "        if ($stmt->execute()) {  \n" + 
	     "            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);  \n" + 
	     "            $rows = Pdoconfig::prepareForAMF($rows, array(0 => '"+ pojoMaster +"'));  \n" + 
	     "        } else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "  \n" + 
	     "        return $rows;  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "  \n" + 
	     "  \n" + 
	     "    // get Detail by ID  \n" + 
	     "    // @result  Detail[]  \n" + 
	     "    // @param $idx = index of Master  \n" + 
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_getAllDtbyID()  \n" + 
	     "    public function get"+pojoDetail+"byId($userid,"+phpkeyMaster+")  \n" + 
	     "    {  \n" + 
	     "        //select * from "+pojoDetail+" where 1=1 and idx= ?  \n" +  
	     "        $stmt = $this->connection->prepare(\"call spMsdt_"+pojoMaster+"_"+pojoDetail+"_getAllDtbyID(:userid,"+keyMaster+");\");  \n" + 
		 "        $stmt->bindParam('userid', $userid);  \n" + 
		 bindKeyMaster +
	     "        if ($stmt->execute()) {  \n" + 
	     "            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);  \n" + 
	     "            $rows = Pdoconfig::prepareForAMF($rows, array(0 => '"+pojoDetail+"'));  \n" + 
	     "        } else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "        return $rows;  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "    // update Master  \n" + 
	     "    // @rerutn int  \n" + 
	     "    // @param $item = Master()  \n" + 
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_UpdateMs()  \n" + 
	     "    public function update"+ pojoMaster +"($userid,$Master)  \n" + 
	     "    {  \n" + 
	     "        // UPDATE "+ pojoMaster +" SET name= :name, docDate= :docDate, total= :total where 1= 1  and idx = "+keyMaster+"  \n" +  
	     "        $stmt = $this->connection->prepare(\"call  spMsdt_"+pojoMaster+"_"+pojoDetail+"_UpdateMs(:userid,"+ paraMaster +" )\");  \n" + 
	     "  \n" + 
		 "        $stmt->bindParam('userid', $userid);  \n" + 
		 bindMaster +
	     "  \n" + 
	     "        if ($stmt->execute()) {  \n" + 
	     "            $row = $stmt->rowCount();  \n" + 
	     "        } else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "        return $row;  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "    // update Detail  \n" + 
	     "    // return int  \n" + 
	     "    // @param $item = Detail()  \n" + 
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_UpdateDt()  \n" + 
	     "    public function update"+pojoDetail+"($userid,$Detail)  \n" + 
	     "    {  \n" + 
	     "        // UPDATE "+pojoDetail+" SET desc= :desc, qty= :qty where 1= 1  and idx = :idx and idNo = :idNo  \n" +  
	     "        $stmt = $this->connection->prepare(\"call spMsdt_"+pojoMaster+"_"+pojoDetail+"_UpdateDt(:userid,"+ paraDetail +");\");  \n" + 
		 "        $stmt->bindParam('userid', $userid);  \n" + 
		 bindDetail + 
	     "        if ($stmt->execute()) {  \n" + 
	     "            $row = $stmt->rowCount();  \n" + 
	     "        } else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "        return $row;  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "    // Void Master  \n" +  
	     "    // Delete All Detail  \n" + 
	     "    // return int  \n" + 
	     "    // @param $idx = index of master  \n" + 
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_voidMs()  \n" + 
	     "    public function void"+pojoMaster+"($userid,"+phpkeyMaster+")  \n" + 
	     "    {  \n" + 
	     "        //update "+pojoMaster+" set status = 'I'  where 1=1  and idx = :idx  \n" + 
	     "        $stmt = $this->connection->prepare(\"call spMsdt_"+pojoMaster+"_"+pojoDetail+"_voidMs(:userid,"+keyMaster+");\");  \n" + 
		 "        $stmt->bindParam('userid', $userid);  \n" + 
		 bindKeyMaster + 
	     "  \n" + 
	     "        if ($stmt->execute()) {  \n" + 
	     "            $row = $stmt->rowCount();  \n" + 
	     "        } else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "        return $row;  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "    // Delet Master & Detail  \n" + 
	     "    // return int  \n" + 
	     "    // @param $idx = indexof Master  \n" + 
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_delMsdt()  \n" + 
	     "    public function delMasterDetail($userid,"+phpkeyMaster+")  \n" + 
	     "    {  \n" + 
	     "        //delete from "+pojoDetail+"  where 1=1  and idx = :idx  \n" +  
	     "        //delete from "+pojoMaster+"  where 1=1   and idx = :idx  \n" + 
	     "        $stmt = $this->connection->prepare(\"call spMsdt_"+pojoMaster+"_"+pojoDetail+"_delMsdt(:userid,"+keyMaster+");\");  \n" + 
		 "        $stmt->bindParam('userid', $userid);  \n" + 
		 bindKeyMaster + 
	     "        if ($stmt->execute()) {  \n" + 
	     "            $row = $stmt->fetch();  \n" + 
	     "        } else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "        return $row;  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "    // Delete Detail  \n" + 
	     "    // return int  \n" + 
	     "    // @param $idx = index of Master  \n" +  
	     "    // @param $idNo = index of Detail  \n" + 
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_delDtitem()  \n" + 
	     "    public function delete"+pojoDetail+"Item($userid,"+phpKeyDetail+")  \n" + 
	     "    {  \n" + 
	     "        //delete from "+pojoDetail+"  where 1=1  and idx = :idx and idNo = :idNo  \n" + 
	     "        $stmt = $this->connection->prepare(\"call spMsdt_"+pojoMaster+"_"+pojoDetail+"_delDtitem(:userid,"+ keyDetail +");\");  \n" + 
		 "        $stmt->bindParam('userid', $userid);  \n" + 
		 bindKeyDetail + 
	     "  \n" + 
	     "        if ($stmt->execute()) {  \n" + 
	     "            $row = $stmt->rowCount();  \n" + 
	     "        } else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "         return $row;  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "    // get Detail Item  \n" + 
	     "    // @result Detail  \n" + 
	     "    // @param $idx = index of "+pojoMaster+" $idNo = index of Detail  \n" +  
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_getDtItem()  \n" + 
	     "    public function get"+pojoDetail+"Item($userid,"+phpKeyDetail+")  \n" + 
	     "    {  \n" + 
	     "        //select * from "+pojoDetail+" where 1=1  and idx = :idx and idNo = :idNo  \n" +  
	     "        $stmt = $this->connection->prepare(\"call spMsdt_"+pojoMaster+"_"+pojoDetail+"_getDtItem(:userid,"+ keyDetail +");\");  \n" + 
		 "        $stmt->bindParam('userid', $userid);  \n" + 
		 bindKeyDetail + 
	     "        if ($stmt->execute()) {  \n" + 
	     "            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);  \n" + 
	     "            $rows = Pdoconfig::prepareForAMF($rows, array(0 => '"+pojoDetail+"'));  \n" + 
	     "        } else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "        return $rows;  \n" + 
	     "    }  \n" + 
	     "      \n" + 
	     "      \n" + 
	     "    // Insert Master  \n" + 
	     "    // @param $item = Master  \n" + 
	     "    // return int  \n" + 
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_InsertMs()  \n" +  
	     "    public function insert"+pojoMaster+"($userid,$Master)  \n" + 
	     "    {  \n" + 
	     "        // Insert Into "+pojoMaster+" ( idx, name, docDate, total ) values ( :idx, :name, :docDate, :total)  \n" + 
	     "        $stmt = $this->connection->prepare(\"call spMsdt_"+pojoMaster+"_"+pojoDetail+"_InsertMs(:userid,"+ paraMaster +");\");  \n" + 
	     "          \n" + 
		 "        $stmt->bindParam('userid', $userid);  \n" + 
		 bindMaster +		 
	     "  \n" + 
	     "        if ($stmt->execute()) {  \n" + 
	     "            $autoid = $this->connection->lastInsertId();  \n" + 
	     "        } else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "        return $autoid;  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "  \n" + 
	     "    // Insert Detail  \n" + 
	     "    // @param @item = Detail  \n" + 
	     "    // return int  \n" + 
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_InsertDt()  \n" + 
	     "    public function insert"+pojoDetail+"($userid,$Detail)  \n" + 
	     "    {  \n" + 
	     "        // Insert Into "+pojoDetail+"(idx, idNo, desc, qty) values (:idx, :idNo, :desc, :qty)  \n" + 
	     "        $stmt = $this->connection->prepare(\"call spMsdt_"+pojoMaster+"_"+pojoDetail+"_InsertDt(:userid,"+ paraDetail +");\");  \n" + 
	     "  \n" +         
		 "        $stmt->bindParam('userid', $userid);  \n" + 
		 bindDetail +	
		 "  \n" + 
	     "        if ($stmt->execute()) {  \n" + 
	     "            $autoid = $this->connection->lastInsertId();  \n" + 
	     "        } else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "        return $autoid;  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "  \n" + 
	     "    // getLastMasterDetail  \n" + 
	     "    // return MasterDetail  \n" + 
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_getLast()  \n" + 
	     "    public function getLastMasterDetail($userid)  \n" + 
	     "    {  \n" + 
	     "        //select * from "+pojoMaster+" ORDER BY idx DESC limit 1  \n" +  
	     "        //select * from "+pojoDetail+" where 1=1 and idx= $masterid  \n" + 
	     "        $stmt = $this->connection->prepare(\"call spMsdt_"+pojoMaster+"_"+pojoDetail+"_getLast(:userid);\");  \n" + 
		 "        $stmt->bindParam('userid', $userid);  \n" + 
	     "         if($stmt->execute()) {  \n" + 
	     "            $result = new MasDetail"+pojoMaster+pojoDetail+"();  \n" + 
	     "            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);  \n" + 
	     "            $rows = Pdoconfig::prepareForAMF($rows,array(0 => '"+pojoMaster+"'));  \n" + 
	     "            $result->master = $rows;  \n" + 
	     "            $stmt->nextRowset();  \n" + 
	     "            $rows1 = $stmt->fetchAll(\PDO::FETCH_ASSOC);  \n" + 
	     "    		$rows1 = Pdoconfig::prepareForAMF($rows1,array(0 => '"+pojoDetail+"'));  \n" + 
	     "            $result->detail = $rows1;  \n" + 
	     "    	} else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "        return $result;  \n" + 
	     "    }  \n" + 
	     "      \n" + 
	     "      \n" + 
	     "    // Not Modyfy  \n" + 
	     "    public function chkSuperAuth($userid, $supUser, $supPasswd, $mod, $func)  \n" + 
	     "    {  \n" + 
	     "        if ($mod == '') {  \n" + 
	     "            $mod = '"+pojoMaster+"';  \n" + 
	     "        }  \n" + 
	     "        $stmt = $this->connection->prepare(\"call spSuperAuth(:userid,:supUser,:supPass,:module,:function)\");  \n" + 
	     "        $stmt->bindParam('userid', $userid);  \n" + 
	     "        $stmt->bindParam('supUser', $supUser);  \n" + 
	     "        $stmt->bindParam('supPass', $supPasswd);  \n" + 
	     "        $stmt->bindParam('module', $mod);  \n" + 
	     "        $stmt->bindParam('function', $func);  \n" + 
	     "        if ($stmt->execute()) {  \n" + 
	     "            $row = $stmt->fetch();  \n" + 
	     "        } else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "        return (int)$row[0];  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "    //Not Modyfy  \n" + 
	     "    public function chkAuth($userid, $mod, $func)  \n" + 
	     "    {  \n" + 
	     "        if ($mod == '') {  \n" + 
	     "            $mod = '"+pojoMaster+"';  \n" + 
	     "        }  \n" + 
	     "        $stmt = $this->connection->prepare(\"call spChkAuth(:userid,:module,:function);\");  \n" + 
	     "        $stmt->bindParam('userid', $userid);  \n" + 
	     "        $stmt->bindParam('module', $mod);  \n" + 
	     "        $stmt->bindParam('function', $func);  \n" + 
	     "        if ($stmt->execute()) {  \n" + 
	     "            $row = $stmt->fetch();  \n" + 
	     "        } else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "        return (int)$row[0];  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "  \n" + 
	     "    // Not Modyfy  \n" + 
	     "    // @param $userid,$docno = index of Master  \n" + 
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_getMsdtforUpdate()  \n" + 
	     "    public function getSessionForUpdate($userid,$docno,$"+pojoMaster+",$"+pojoDetail+")  \n" + 
	     "    {  \n" + 
	     "        //fcControlUpdateTable(`_userid`,`_DocNo`,_"+pojoMaster+",_"+pojoDetail+")  \n" + 
	     "        $stmt = $this->connection->prepare(\"call spMsdt_"+pojoMaster+"_"+pojoDetail+"_getMsdtforUpdate(:userid,:docNo,:"+pojoMaster+",:"+pojoDetail+");\");  \n" + 
	     "        $stmt->bindParam('userid', $userid);  \n" + 
	     "        $stmt->bindParam('docno', $docno);  \n" + 
	     "        $stmt->bindParam('"+pojoMaster+"', $"+pojoMaster+");  \n" + 
	     "        $stmt->bindParam('"+pojoDetail+"', $"+pojoDetail+");  \n" + 
	     "        if ($stmt->execute()) {  \n" + 
	     "            $row = $stmt->fetch();  \n" + 
	     "        } else {  \n" + 
	     "            $errorInfo = $stmt->errorInfo();  \n" + 
	     "            $this->echoError($errorInfo);  \n" + 
	     "        }  \n" + 
	     "        return (int)$row[0];  \n" + 
	     "  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "    // Not Modify  \n" + 
	     "    // @param  $userid $module  \n" + 
	     "    // spMsdt_"+pojoMaster+"_"+pojoDetail+"_CompleteSessionforUpdate()  \n" +   
	     "    public function completeSessionForUpdate($userid,$mod)  \n" + 
	     "    {  \n" +
		 "        if ($mod == '') {  \n" + 
		 "            $mod = '"+pojoMaster+"';  \n" + 
		 "        }  \n" + 
	     "        //fcCompleteUpdateTable(:userid,:module)  \n" + 
		 "        $stmt->bindParam('userid', $userid);  \n" + 
		 "        $stmt->bindParam('module', $mod);  \n" + 
	     "  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "    //Echo Error message  \n" + 
	     "    private function echoError($errorInfo)  \n" + 
	     "    {  \n" + 
	     "        throw new Exception('MySQL Error ' . $errorInfo[2], $errorInfo[1]);  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "    public function __destruct()  \n" + 
	     "    {  \n" + 
	     "        $this->connection = null;  \n" + 
	     "    }  \n" + 
	     "  \n" + 
	     "}  \n" + 
	     "  \n" + 
	     "  \n" + 
	     "class "+pojoMaster+"  \n" + 
	     "{  \n" + 
		 pmaster +
		 "}  \n" + 
	     "  \n" + 
	     "class "+pojoDetail+"  \n" + 
	     "{  \n" + 
		 pdetail +
	     "  \n" + 
	     "}  \n" + 
	     "class MasDetail"+pojoMaster+pojoDetail+"  \n" + 
	     "{  \n" + 
	     "    public $master;  \n" + 
	     "    public $detail;  \n" + 
	     "}  \n" + 
	     "  \n"; 
     return php;
     }
     
	}
}