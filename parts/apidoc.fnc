::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:
:  !!!! Do NOT edit this file directly! -- Edit devel/mkapidoc.sh instead. !!!!
:
:  This file was automatically generated from the API documentation scattered
:  all over the Perl source code. To learn more about how all this works,
:  please read the F<HACKERS> file that came with this distribution.
:
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:
: This file lists all API functions/macros that are documented in the Perl
: source code, but are not contained in F<embed.fnc>.
:

: This line needs to be in this file for things to work, even though it's been
: removed from later embed.fnc versions
ApTod   |int    |my_sprintf     |NN char *buffer|NN const char *pat|...

ADmnU||Nullav
ADmnU||Nullcv
ADmnU||Nullhv
Ama|char*|savepvs|"literal string" s
Ama|char*|savesharedpvs|"literal string" s
Ama|SV*|newSVpvs_flags|"literal string" s|U32 flags
Ama|SV*|newSVpvs|"literal string" s
Ama|SV*|newSVpvs_share|"literal string" s
Am|AV*|GvAV|GV* gv
Am|bool|ckWARN2_d|U32 w1|U32 w2
Am|bool|ckWARN2|U32 w1|U32 w2
Am|bool|ckWARN3_d|U32 w1|U32 w2|U32 w3
Am|bool|ckWARN3|U32 w1|U32 w2|U32 w3
Am|bool|ckWARN4_d|U32 w1|U32 w2|U32 w3|U32 w4
Am|bool|ckWARN4|U32 w1|U32 w2|U32 w3|U32 w4
Am|bool|ckWARN_d|U32 w
Am|bool|ckWARN|U32 w
Am|bool|DO_UTF8|SV* sv
Am|bool|isALPHA|int ch
Am|bool|isALPHANUMERIC|int ch
Am|bool|isASCII|int ch
Am|bool|isBLANK|char ch
Am|bool|isCNTRL|char ch
Am|bool|isDIGIT|char ch
Am|bool|isGRAPH|char ch
Am|bool|isIDCONT|char ch
Am|bool|isIDFIRST|char ch
Am|bool|isLOWER|char ch
Am|bool|isOCTAL|char ch
Am|bool|isPRINT|char ch
Am|bool|isPSXSPC|char ch
Am|bool|isPUNCT|char ch
Am|bool|isSPACE|char ch
Am|bool|isUPPER|char ch
Am|bool|isWORDCHAR|char ch
Am|bool|isXDIGIT|char ch
Am|bool|memEQ|char* s1|char* s2|STRLEN len
Am|bool|memNE|char* s1|char* s2|STRLEN len
Am|bool|OpHAS_SIBLING|OP *o
Am|bool|OP_TYPE_IS|OP *o|Optype type
Am|bool|OP_TYPE_IS_OR_WAS|OP *o|Optype type
Am|bool|strEQ|char* s1|char* s2
Am|bool|strGE|char* s1|char* s2
Am|bool|strGT|char* s1|char* s2
Am|bool|strLE|char* s1|char* s2
Am|bool|strLT|char* s1|char* s2
Am|bool|strNE|char* s1|char* s2
Am|bool|strnEQ|char* s1|char* s2|STRLEN len
Am|bool|strnNE|char* s1|char* s2|STRLEN len
Am|bool|SvIOK_notUV|SV* sv
Am|bool|SvIOK_UV|SV* sv
Am|bool|SvIsCOW_shared_hash|SV* sv
Am|bool|SvRXOK|SV* sv
Am|bool|SvTAINTED|SV* sv
Am|bool|SvTRUE_nomg|SV* sv
Am|bool|SvTRUE|SV* sv
Am|bool|SvTRUEx|SV* sv
Am|bool|SvUOK|SV* sv
Am|bool|SvVOK|SV* sv
Am|bool|UTF8_IS_INVARIANT|char c
Am|bool|UTF8_IS_NONCHAR|const U8 *s|const U8 *e
Am|bool|UTF8_IS_SUPER|const U8 *s|const U8 *e
Am|bool|UTF8_IS_SURROGATE|const U8 *s|const U8 *e
Am|bool|UVCHR_IS_INVARIANT|UV cp
Am|char*|HePV|HE* he|STRLEN len
Am|char*|HvENAME|HV* stash
Am|char*|HvNAME|HV* stash
Am|char*|SvEND|SV* sv
Am|char *|SvGROW|SV* sv|STRLEN len
Am|char*|SvPVbyte_force|SV* sv|STRLEN len
Am|char*|SvPVbyte_nolen|SV* sv
Am|char*|SvPVbyte|SV* sv|STRLEN len
Am|char*|SvPVbytex_force|SV* sv|STRLEN len
Am|char*|SvPVbytex|SV* sv|STRLEN len
Am|char *|SvPVCLEAR|SV* sv
Am|char*|SvPV_force_nomg|SV* sv|STRLEN len
Am|char*|SvPV_force|SV* sv|STRLEN len
Am|char*|SvPV_nolen|SV* sv
Am|char*|SvPV_nomg_nolen|SV* sv
Am|char*|SvPV_nomg|SV* sv|STRLEN len
Am|char*|SvPV|SV* sv|STRLEN len
Am|char*|SvPVutf8_force|SV* sv|STRLEN len
Am|char*|SvPVutf8_nolen|SV* sv
Am|char*|SvPVutf8|SV* sv|STRLEN len
Am|char*|SvPVutf8x_force|SV* sv|STRLEN len
Am|char*|SvPVutf8x|SV* sv|STRLEN len
Am|char*|SvPVX|SV* sv
Am|char*|SvPVx|SV* sv|STRLEN len
Am|const char *|OP_DESC|OP *o
Am|const char *|OP_NAME|OP *o
Am|CV*|GvCV|GV* gv
Am|HV *|cop_hints_2hv|const COP *cop|U32 flags
Am|HV*|CvSTASH|CV* cv
Am|HV*|GvHV|GV* gv
Am|HV*|gv_stashpvs|"literal string" name|I32 create
Am|HV*|SvSTASH|SV* sv
Am|int|AvFILL|AV* av
Am|IV|SvIV_nomg|SV* sv
Am|IV|SvIV|SV* sv
Am|IV|SvIVx|SV* sv
Am|IV|SvIVX|SV* sv
Amn|char*|CLASS
Amn|char*|POPp
Amn|char*|POPpbytex
Amn|char*|POPpx
Amn|COP*|PL_curcop
Amn|GV *|PL_defgv
Amn|HV*|PL_curstash
Amn|HV*|PL_modglobal
Amn|I32|ax
Amn|I32|items
Amn|I32|ix
Amn|IV|POPi
Amn|long|POPl
Amn|long|POPul
Amn|NV|POPn
Amn|peep_t|PL_peepp
Amn|peep_t|PL_rpeepp
Amn|Perl_ophook_t|PL_opfreehook
Amn|runops_proc_t|PL_runops
Amns||dAX
Amns||dAXMARK
Amns||dITEMS
Amns||dMARK
Amns||dMULTICALL
Amns||dORIGMARK
Amns||dSP
Amns||dUNDERBAR
Amns||dXCPT
Amns||dXSARGS
Amns||dXSI32
Amns||ENTER
Amns||FREETMPS
Amn|signed char|PL_perl_destruct_level
Amns||LEAVE
Amns||MULTICALL
Amns||POP_MULTICALL
Amns||PUTBACK
Amns||SAVETMPS
Amns||SPAGAIN
Amn|STRLEN|PL_na
Amn|SV *|ERRSV
Amn|SV|PL_sv_no
Amn|SV|PL_sv_undef
Amn|SV|PL_sv_yes
Amn|SV|PL_sv_zero
Amn|SV*|POPs
Amns||XCPT_RETHROW
Amns||XS_APIVERSION_BOOTCHECK
Amns||XSRETURN_EMPTY
Amns||XSRETURN_NO
Amns||XSRETURN_UNDEF
Amns||XSRETURN_YES
Amns||XS_VERSION_BOOTCHECK
Amn|U32|GIMME
Amn|U32|GIMME_V
Amn|U8|PL_exit_flags
AmnU|const char *|BOM_UTF8
AmnU|const char *|REPLACEMENT_CHARACTER_UTF8
AmnU||G_ARRAY
AmnU||G_DISCARD
AmnU||G_EVAL
AmnU||G_NOARGS
AmnU||G_SCALAR
AmnU||G_VOID
AmnU||HEf_SVKEY
AmnU||MARK
AmnU||Nullch
AmnU||Nullsv
AmnU||ORIGMARK
AmnU|Perl_check_t *|PL_check
AmnU||SP
AmnU||SVt_INVLIST
AmnU||SVt_IV
AmnU||SVt_NULL
AmnU||SVt_NV
AmnU||SVt_PV
AmnU||SVt_PVAV
AmnU||SVt_PVCV
AmnU||SVt_PVFM
AmnU||SVt_PVGV
AmnU||SVt_PVHV
AmnU||SVt_PVIO
AmnU||SVt_PVIV
AmnU||SVt_PVLV
AmnU||SVt_PVMG
AmnU||SVt_PVNV
AmnU||SVt_REGEXP
AmnU||svtype
AmnU||UNDERBAR
Amn|UV|POPu
AmnU||XCPT_CATCH
AmnU||XCPT_TRY_END
AmnU||XCPT_TRY_START
AmnUx|Perl_keyword_plugin_t|PL_keyword_plugin
AmnU||XS
AmnU||XS_EXTERNAL
AmnU||XS_VERSION
AmnU|yy_parser *|PL_parser
Amn|void|DECLARATION_FOR_LC_NUMERIC_MANIPULATION
Amn|void|PUSHmortal
Amn|void|XPUSHmortal
Am|NV|SvNV_nomg|SV* sv
Am|NV|SvNV|SV* sv
Am|NV|SvNVx|SV* sv
Am|NV|SvNVX|SV* sv
Amn|(whatever)|RETVAL
Amn|(whatever)|THIS
AmnxUN|char *|PL_parser-E<gt>bufend
AmnxUN|char *|PL_parser-E<gt>bufptr
AmnxUN|char *|PL_parser-E<gt>linestart
AmnxUN|SV *|PL_parser-E<gt>linestr
AmnxU|PADNAMELIST *|PL_comppad_name
AmnxU|PAD *|PL_comppad
AmnxU|SV **|PL_curpad
Amn|yy_parser*|PL_parser
Am|OP*|LINKLIST|OP *o
Am|OP*|OpSIBLING|OP *o
Am|PADOFFSET|pad_add_name_pvs|"literal string" name|U32 flags|HV *typestash|HV *ourstash
Am|PADOFFSET|pad_findmy_pvs|"literal string" name|U32 flags
Am|REGEXP *|SvRX|SV *sv
Ams||ENTER_with_name|const char * name
Ams||LEAVE_with_name|const char * name
Ams||PUSH_MULTICALL|CV* the_cv
Am|STRLEN|HeKLEN|HE* he
Am|STRLEN|HvENAMELEN|HV *stash
Am|STRLEN|HvNAMELEN|HV *stash
Am|STRLEN|isUTF8_CHAR_flags|const U8 *s|const U8 *e| const U32 flags
Am|STRLEN|SvCUR|SV* sv
Am|STRLEN|SvLEN|SV* sv
Am|STRLEN|UTF8_SAFE_SKIP|char* s|char* e
Am|STRLEN|UTF8SKIP|char* s
Am|STRLEN|UVCHR_SKIP|UV cp
Am|SV *|boolSV|bool b
Am|SV *|cop_hints_fetch_pv|const COP *cop|const char *key|U32 hash|U32 flags
Am|SV *|cop_hints_fetch_pvn|const COP *cop|const char *keypv|STRLEN keylen|U32 hash|U32 flags
Am|SV *|cop_hints_fetch_pvs|const COP *cop|"literal string" key|U32 flags
Am|SV *|cop_hints_fetch_sv|const COP *cop|SV *key|U32 hash|U32 flags
Am|SV*|GvSV|GV* gv
Am|SV*|HeSVKEY_force|HE* he
Am|SV*|HeSVKEY|HE* he
Am|SV*|HeSVKEY_set|HE* he|SV* sv
Am|SV*|HeVAL|HE* he
Am|SV**|hv_fetchs|HV* tb|"literal string" key|I32 lval
Am|SV**|hv_stores|HV* tb|"literal string" key|SV* val
Am|SV*|newRV_inc|SV* sv
Am|SV*|newSVpvn_utf8|const char* s|STRLEN len|U32 utf8
Am|SV*|ST|int ix
Am|SV*|SvREFCNT_inc_NN|SV* sv
Am|SV*|SvREFCNT_inc_simple_NN|SV* sv
Am|SV*|SvREFCNT_inc_simple|SV* sv
Am|SV*|SvREFCNT_inc|SV* sv
Am|SV*|SvRV|SV* sv
Am|SV *|sv_setref_pvs|SV *const rv|const char *const classname|"literal string" s
Am|svtype|SvTYPE|SV* sv
Am|U32|HeHASH|HE* he
Am|U32|HeUTF8|HE* he
Am|U32|OP_CLASS|OP *o
Am|U32|SvGAMAGIC|SV* sv
Am|U32|SvIOKp|SV* sv
Am|U32|SvIOK|SV* sv
Am|U32|SvIsCOW|SV* sv
Am|U32|SvNIOKp|SV* sv
Am|U32|SvNIOK|SV* sv
Am|U32|SvNOKp|SV* sv
Am|U32|SvNOK|SV* sv
Am|U32|SvOK|SV* sv
Am|U32|SvOOK|SV* sv
Am|U32|SvPOKp|SV* sv
Am|U32|SvPOK|SV* sv
Am|U32|SvREADONLY_off|SV* sv
Am|U32|SvREADONLY_on|SV* sv
Am|U32|SvREADONLY|SV* sv
Am|U32|SvREFCNT|SV* sv
Am|U32|SvROK|SV* sv
Am|U32|SvUTF8|SV* sv
Am|U32|XopFLAGS|XOP *xop
Am|U8|READ_XDIGIT|char str*
Am|U8|toFOLD|U8 ch
Am|U8|toLOWER_L1|U8 ch
Am|U8|toLOWER_LC|U8 ch
Am|U8|toLOWER|U8 ch
Am|U8|toTITLE|U8 ch
Am|U8|toUPPER|int ch
AmU||newXSproto|char* name|XSUBADDR_t f|char* filename|const char *proto
Am|unsigned char|HvENAMEUTF8|HV *stash
Am|unsigned char|HvNAMEUTF8|HV *stash
Am|UV|SvUV_nomg|SV* sv
Am|UV|SvUV|SV* sv
Am|UV|SvUVx|SV* sv
Am|UV|SvUVX|SV* sv
Am|UV|toFOLD_utf8_safe|U8* p|U8* e|U8* s|STRLEN* lenp
Am|UV|toFOLD_utf8|U8* p|U8* s|STRLEN* lenp
Am|UV|toFOLD_uvchr|UV cp|U8* s|STRLEN* lenp
Am|UV|toLOWER_utf8_safe|U8* p|U8* e|U8* s|STRLEN* lenp
Am|UV|toLOWER_utf8|U8* p|U8* s|STRLEN* lenp
Am|UV|toLOWER_uvchr|UV cp|U8* s|STRLEN* lenp
Am|UV|toTITLE_utf8_safe|U8* p|U8* e|U8* s|STRLEN* lenp
Am|UV|toTITLE_utf8|U8* p|U8* s|STRLEN* lenp
Am|UV|toTITLE_uvchr|UV cp|U8* s|STRLEN* lenp
Am|UV|toUPPER_utf8_safe|U8* p|U8* e|U8* s|STRLEN* lenp
Am|UV|toUPPER_utf8|U8* p|U8* s|STRLEN* lenp
Am|UV|toUPPER_uvchr|UV cp|U8* s|STRLEN* lenp
AmU||XS_INTERNAL
Am|void|CLEAR_ERRSV
Am|void *|CopyD|void* src|void* dest|int nitems|type
Am|void|Copy|void* src|void* dest|int nitems|type
Am|void|EXTEND|SP|SSize_t nitems
Am|void*|HeKEY|HE* he
Am|void *|MoveD|void* src|void* dest|int nitems|type
Am|void|Move|void* src|void* dest|int nitems|type
Am|void|mPUSHi|IV iv
Am|void|mPUSHn|NV nv
Am|void|mPUSHp|char* str|STRLEN len
Am|void|mPUSHs|SV* sv
Am|void|mPUSHu|UV uv
Am|void|mXPUSHi|IV iv
Am|void|mXPUSHn|NV nv
Am|void|mXPUSHp|char* str|STRLEN len
Am|void|mXPUSHs|SV* sv
Am|void|mXPUSHu|UV uv
Am|void|Newxc|void* ptr|int nitems|type|cast
Am|void|Newx|void* ptr|int nitems|type
Am|void|Newxz|void* ptr|int nitems|type
Am|void|OpLASTSIB_set|OP *o|OP *parent
Am|void|OpMAYBESIB_set|OP *o|OP *sib|OP *parent
Am|void|OpMORESIB_set|OP *o|OP *sib
Am|void|PERL_SYS_INIT3|int *argc|char*** argv|char*** env
Am|void|PERL_SYS_INIT|int *argc|char*** argv
Am|void|PERL_SYS_TERM|
Am|void|PoisonFree|void* dest|int nitems|type
Am|void|PoisonNew|void* dest|int nitems|type
Am|void|Poison|void* dest|int nitems|type
Am|void|PoisonWith|void* dest|int nitems|type|U8 byte
Am|void|PUSHi|IV iv
Am|void|PUSHMARK|SP
Am|void|PUSHn|NV nv
Am|void|PUSHp|char* str|STRLEN len
Am|void|PUSHs|SV* sv
Am|void|PUSHu|UV uv
Am|void|Renewc|void* ptr|int nitems|type|cast
Am|void|Renew|void* ptr|int nitems|type
Am|void|RESTORE_LC_NUMERIC
Am|void|Safefree|void* ptr
Am|void|SANE_ERRSV
Am|void|STORE_LC_NUMERIC_FORCE_TO_UNDERLYING
Am|void|STORE_LC_NUMERIC_SET_TO_NEEDED
Am|void|STORE_LC_NUMERIC_SET_TO_NEEDED_IN|bool in_lc_numeric
Am|void|StructCopy|type *src|type *dest|type
Am|void|sv_catpvn_nomg|SV* sv|const char* ptr|STRLEN len
Am|void|sv_catpv_nomg|SV* sv|const char* ptr
Am|void|sv_catpvs_flags|SV* sv|"literal string" s|I32 flags
Am|void|sv_catpvs_mg|SV* sv|"literal string" s
Am|void|sv_catpvs_nomg|SV* sv|"literal string" s
Am|void|sv_catpvs|SV* sv|"literal string" s
Am|void|sv_catsv_nomg|SV* dsv|SV* ssv
Am|void|SvCUR_set|SV* sv|STRLEN len
Am|void|SvGETMAGIC|SV* sv
Am|void|SvIOK_off|SV* sv
Am|void|SvIOK_only|SV* sv
Am|void|SvIOK_only_UV|SV* sv
Am|void|SvIOK_on|SV* sv
Am|void|SvIV_set|SV* sv|IV val
Am|void|SvLEN_set|SV* sv|STRLEN len
Am|void|SvLOCK|SV* sv
Am|void|SvMAGIC_set|SV* sv|MAGIC* val
Am|void|SvNIOK_off|SV* sv
Am|void|SvNOK_off|SV* sv
Am|void|SvNOK_only|SV* sv
Am|void|SvNOK_on|SV* sv
Am|void|SvNV_set|SV* sv|NV val
Am|void|SvOOK_offset|SV*sv|STRLEN len
Am|void|SvPOK_off|SV* sv
Am|void|SvPOK_only|SV* sv
Am|void|SvPOK_only_UTF8|SV* sv
Am|void|SvPOK_on|SV* sv
Am|void|SvPV_set|SV* sv|char* val
Am|void|SvREFCNT_dec_NN|SV* sv
Am|void|SvREFCNT_dec|SV* sv
Am|void|SvREFCNT_inc_simple_void_NN|SV* sv
Am|void|SvREFCNT_inc_simple_void|SV* sv
Am|void|SvREFCNT_inc_void_NN|SV* sv
Am|void|SvREFCNT_inc_void|SV* sv
Am|void|SvROK_off|SV* sv
Am|void|SvROK_on|SV* sv
Am|void|SvRV_set|SV* sv|SV* val
Am|void|SvSetMagicSV_nosteal|SV* dsv|SV* ssv
Am|void|SvSETMAGIC|SV* sv
Am|void|SvSetMagicSV|SV* dsv|SV* ssv
Am|void|sv_setpvs_mg|SV* sv|"literal string" s
Am|void|sv_setpvs|SV* sv|"literal string" s
Am|void|sv_setsv_nomg|SV* dsv|SV* ssv
Am|void|SvSetSV_nosteal|SV* dsv|SV* ssv
Am|void|SvSetSV|SV* dsv|SV* ssv
Am|void|SvSHARE|SV* sv
Am|void|SvSTASH_set|SV* sv|HV* val
Am|void|SvTAINTED_off|SV* sv
Am|void|SvTAINTED_on|SV* sv
Am|void|SvTAINT|SV* sv
Am|void|SvUNLOCK|SV* sv
Am|void|SvUPGRADE|SV* sv|svtype type
Am|void|SvUTF8_off|SV *sv
Am|void|SvUTF8_on|SV *sv
Am|void|SvUV_set|SV* sv|UV val
Am|void|WITH_LC_NUMERIC_SET_TO_NEEDED
Am|void|WITH_LC_NUMERIC_SET_TO_NEEDED_IN|bool in_lc_numeric
Am|void|XopDISABLE|XOP *xop|which
Am|void|XopENABLE|XOP *xop|which
Am|void|XopENTRY_set|XOP *xop|which|value
Am|void|XPUSHi|IV iv
Am|void|XPUSHn|NV nv
Am|void|XPUSHp|char* str|STRLEN len
Am|void|XPUSHs|SV* sv
Am|void|XPUSHu|UV uv
Am|void|XSRETURN|int nitems
Am|void|XSRETURN_IV|IV iv
Am|void|XSRETURN_NV|NV nv
Am|void|XSRETURN_PV|char* str
Am|void|XSRETURN_UV|IV uv
Am|void|XST_mIV|int pos|IV iv
Am|void|XST_mNO|int pos
Am|void|XST_mNV|int pos|NV nv
Am|void|XST_mPV|int pos|char* str
Am|void|XST_mUNDEF|int pos
Am|void|XST_mYES|int pos
Am|void *|ZeroD|void* dest|int nitems|type
Am|void|Zero|void* dest|int nitems|type
Amx|bool|PadnameUTF8|PADNAME * pn
Amx|char *|PadnamePV|PADNAME * pn
Amx|COPHH *|cophh_copy|COPHH *cophh
Amx|COPHH *|cophh_delete_pv|const COPHH *cophh|const char *key|U32 hash|U32 flags
Amx|COPHH *|cophh_delete_pvn|COPHH *cophh|const char *keypv|STRLEN keylen|U32 hash|U32 flags
Amx|COPHH *|cophh_delete_pvs|const COPHH *cophh|"literal string" key|U32 flags
Amx|COPHH *|cophh_delete_sv|const COPHH *cophh|SV *key|U32 hash|U32 flags
Amx|COPHH *|cophh_new_empty
Amx|COPHH *|cophh_store_pv|const COPHH *cophh|const char *key|U32 hash|SV *value|U32 flags
Amx|COPHH *|cophh_store_pvn|COPHH *cophh|const char *keypv|STRLEN keylen|U32 hash|SV *value|U32 flags
Amx|COPHH *|cophh_store_pvs|const COPHH *cophh|"literal string" key|SV *value|U32 flags
Amx|COPHH *|cophh_store_sv|const COPHH *cophh|SV *key|U32 hash|SV *value|U32 flags
Amx|HV *|cophh_2hv|const COPHH *cophh|U32 flags
Am||XopENTRYCUSTOM|const OP *o|which
Am||XopENTRY|XOP *xop|which
Amx|PADLIST *|CvPADLIST|CV *cv
Amx|PADNAMELIST *|PadlistNAMES|PADLIST * padlist
Amx|PADNAME **|PadlistNAMESARRAY|PADLIST * padlist
Amx|PADNAME **|PadnamelistARRAY|PADNAMELIST * pnl
Amx|PAD **|PadlistARRAY|PADLIST * padlist
Amx|SSize_t|PadlistMAX|PADLIST * padlist
Amx|SSize_t|PadlistNAMESMAX|PADLIST * padlist
Amx|SSize_t|PadMAX|PAD * pad
Amx|SSize_t|PadnamelistMAX|PADNAMELIST * pnl
Amx|SSize_t|PadnamelistREFCNT|PADNAMELIST * pnl
Amx|SSize_t|PadnameREFCNT|PADNAME * pn
Amx|STRLEN|PadnameLEN|PADNAME * pn
Amx|SV *|cophh_fetch_pv|const COPHH *cophh|const char *key|U32 hash|U32 flags
Amx|SV *|cophh_fetch_pvn|const COPHH *cophh|const char *keypv|STRLEN keylen|U32 hash|U32 flags
Amx|SV *|cophh_fetch_pvs|const COPHH *cophh|"literal string" key|U32 flags
Amx|SV *|cophh_fetch_sv|const COPHH *cophh|SV *key|U32 hash|U32 flags
Amx|SV*|newSVpadname|PADNAME *pn
Amx|SV **|PadARRAY|PAD * pad
Amx|SV *|PadnameSV|PADNAME * pn
Amx|U32|PadlistREFCNT|PADLIST * padlist
Amx|void|BhkDISABLE|BHK *hk|which
Amx|void|BhkENABLE|BHK *hk|which
Amx|void|BhkENTRY_set|BHK *hk|which|void *ptr
Amx|void|cophh_free|COPHH *cophh
Amx|void|lex_stuff_pvs|"literal string" pv|U32 flags
Amx|void|PadnamelistREFCNT_dec|PADNAMELIST * pnl
Amx|void|PadnameREFCNT_dec|PADNAME * pn
ATmD|int|my_sprintf|NN char *buffer|NN const char *pat|...
m|bool|CvWEAKOUTSIDE|CV *cv
m|bool|PadnameIsOUR|PADNAME * pn
m|bool|PadnameIsSTATE|PADNAME * pn
m|bool|PadnameOUTER|PADNAME * pn
m|char *|PAD_COMPNAME_PV|PADOFFSET po
m|HV *|PAD_COMPNAME_OURSTASH|PADOFFSET po
m|HV *|PAD_COMPNAME_TYPE|PADOFFSET po
m|HV *|PadnameOURSTASH
m|HV *|PadnameTYPE|PADNAME * pn
mn|GV *|PL_DBsub
mn|GV*|PL_last_in_gv
mn|GV*|PL_ofsgv
mn|SV *|PL_DBsingle
mn|SV *|PL_DBtrace
mn|SV*|PL_rs
mn|U8|PL_dowarn
mnU||LVRET
mn|void|dSAVEDERRNO
mn|void|dSAVE_ERRNO
mn|void|RESTORE_ERRNO
mn|void|SAVE_ERRNO
ms||djSP
m|STRLEN|PAD_COMPNAME_GEN|PADOFFSET po
m|STRLEN|PAD_COMPNAME_GEN_set|PADOFFSET po|int gen
m|struct refcounted_he *|refcounted_he_new_pvs|struct refcounted_he *parent|"literal string" key|SV *value|U32 flags
m|SV *|CX_CURPAD_SV|struct context|PADOFFSET po
m|SV *|PAD_BASE_SV	|PADLIST padlist|PADOFFSET po
m|SV *|PAD_SETSV	|PADOFFSET po|SV* sv
m|SV *|PAD_SVl	|PADOFFSET po
m|SV *|PAD_SV	|PADOFFSET po
m|SV *|refcounted_he_fetch_pvs|const struct refcounted_he *chain|"literal string" key|U32 flags
m|U32|PAD_COMPNAME_FLAGS|PADOFFSET po
m|U32|SvTHINKFIRST|SV *sv
m|void|CX_CURPAD_SAVE|struct context
m|void|PAD_CLONE_VARS|PerlInterpreter *proto_perl|CLONE_PARAMS* param
m|void|PAD_RESTORE_LOCAL|PAD *opad
m|void|PAD_SAVE_LOCAL|PAD *opad|PAD *npad
m|void|PAD_SAVE_SETNULLPAD
m|void|PAD_SET_CUR_NOSAVE	|PADLIST padlist|I32 n
m|void|PAD_SET_CUR	|PADLIST padlist|I32 n
m|void|SAVECLEARSV	|SV **svp
m|void|SAVECOMPPAD
m|void|SAVEPADSV	|PADOFFSET po
m|void|SETERRNO|int errcode|int vmserrcode
mx|U32|BhkFLAGS|BHK *hk
mx|void *|BhkENTRY|BHK *hk|which
mx|void|CALL_BLOCK_HOOKS|which|arg
