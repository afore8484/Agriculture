/*
 Yudao Database Transfer Tool

 Source Server Type    : MySQL

 Target Server Type    : Microsoft SQL Server

 Date: 2025-05-22 21:03:59
*/


-- ----------------------------
-- Table structure for dual
-- ----------------------------
DROP TABLE IF EXISTS dual
GO
CREATE TABLE dual
(
    id int
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏁版嵁搴撹繛鎺ョ殑琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'dual'
GO

-- ----------------------------
-- Records of dual
-- ----------------------------
-- @formatter:off
INSERT INTO dual VALUES (1)
GO
-- @formatter:on

-- ----------------------------
-- Table structure for infra_api_access_log
-- ----------------------------
DROP TABLE IF EXISTS infra_api_access_log
GO
CREATE TABLE infra_api_access_log
(
    id               bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    trace_id         nvarchar(64)  DEFAULT ''                NOT NULL,
    user_id          bigint        DEFAULT 0                 NOT NULL,
    user_type        tinyint       DEFAULT 0                 NOT NULL,
    application_name nvarchar(50)                            NOT NULL,
    request_method   nvarchar(16)  DEFAULT ''                NOT NULL,
    request_url      nvarchar(255) DEFAULT ''                NOT NULL,
    request_params   nvarchar(max)                           NULL,
    response_body    nvarchar(max)                           NULL,
    user_ip          nvarchar(50)                            NOT NULL,
    user_agent       nvarchar(512)                           NOT NULL,
    operate_module   nvarchar(50)  DEFAULT NULL              NULL,
    operate_name     nvarchar(50)  DEFAULT NULL              NULL,
    operate_type     tinyint       DEFAULT 0                 NULL,
    begin_time       datetime2                               NOT NULL,
    end_time         datetime2                               NOT NULL,
    duration         int                                     NOT NULL,
    result_code      int           DEFAULT 0                 NOT NULL,
    result_msg       nvarchar(512) DEFAULT ''                NULL,
    creator          nvarchar(64)  DEFAULT ''                NULL,
    create_time      datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater          nvarchar(64)  DEFAULT ''                NULL,
    update_time      datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted          bit           DEFAULT 0                 NOT NULL,
    tenant_id        bigint        DEFAULT 0                 NOT NULL
)
GO

CREATE INDEX idx_infra_api_access_log_01 ON infra_api_access_log (create_time)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏃ュ織涓婚敭',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閾捐矾杩借釜缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'trace_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'搴旂敤鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'application_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璇锋眰鏂规硶鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'request_method'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璇锋眰鍦板潃',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'request_url'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璇锋眰鍙傛暟',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'request_params'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍝嶅簲缁撴灉',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'response_body'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛 IP',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'user_ip'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'娴忚鍣?UA',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'user_agent'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎿嶄綔妯″潡',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'operate_module'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎿嶄綔鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'operate_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎿嶄綔鍒嗙被',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'operate_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮€濮嬭姹傛椂闂?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'begin_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缁撴潫璇锋眰鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'end_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎵ц鏃堕暱',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'duration'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缁撴灉鐮?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'result_code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缁撴灉鎻愮ず',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'result_msg'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'API 璁块棶鏃ュ織琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_access_log'
GO

-- ----------------------------
-- Table structure for infra_api_error_log
-- ----------------------------
DROP TABLE IF EXISTS infra_api_error_log
GO
CREATE TABLE infra_api_error_log
(
    id                           bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    trace_id                     nvarchar(64)                            NOT NULL,
    user_id                      bigint        DEFAULT 0                 NOT NULL,
    user_type                    tinyint       DEFAULT 0                 NOT NULL,
    application_name             nvarchar(50)                            NOT NULL,
    request_method               nvarchar(16)                            NOT NULL,
    request_url                  nvarchar(255)                           NOT NULL,
    request_params               nvarchar(4000)                          NOT NULL,
    user_ip                      nvarchar(50)                            NOT NULL,
    user_agent                   nvarchar(512)                           NOT NULL,
    exception_time               datetime2                               NOT NULL,
    exception_name               nvarchar(128) DEFAULT ''                NOT NULL,
    exception_message            nvarchar(max)                           NOT NULL,
    exception_root_cause_message nvarchar(max)                           NOT NULL,
    exception_stack_trace        nvarchar(max)                           NOT NULL,
    exception_class_name         nvarchar(512)                           NOT NULL,
    exception_file_name          nvarchar(512)                           NOT NULL,
    exception_method_name        nvarchar(512)                           NOT NULL,
    exception_line_number        int                                     NOT NULL,
    process_status               tinyint                                 NOT NULL,
    process_time                 datetime2     DEFAULT NULL              NULL,
    process_user_id              int           DEFAULT 0                 NULL,
    creator                      nvarchar(64)  DEFAULT ''                NULL,
    create_time                  datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater                      nvarchar(64)  DEFAULT ''                NULL,
    update_time                  datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted                      bit           DEFAULT 0                 NOT NULL,
    tenant_id                    bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閾捐矾杩借釜缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'trace_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'搴旂敤鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'application_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璇锋眰鏂规硶鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'request_method'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璇锋眰鍦板潃',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'request_url'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璇锋眰鍙傛暟',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'request_params'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛 IP',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'user_ip'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'娴忚鍣?UA',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'user_agent'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮傚父鍙戠敓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'exception_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮傚父鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'exception_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮傚父瀵艰嚧鐨勬秷鎭?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'exception_message'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮傚父瀵艰嚧鐨勬牴娑堟伅',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'exception_root_cause_message'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮傚父鐨勬爤杞ㄨ抗',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'exception_stack_trace'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮傚父鍙戠敓鐨勭被鍏ㄥ悕',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'exception_class_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮傚父鍙戠敓鐨勭被鏂囦欢',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'exception_file_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮傚父鍙戠敓鐨勬柟娉曞悕',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'exception_method_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮傚父鍙戠敓鐨勬柟娉曟墍鍦ㄨ',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'exception_line_number'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶勭悊鐘舵€?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'process_status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶勭悊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'process_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶勭悊鐢ㄦ埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'process_user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绯荤粺寮傚父鏃ュ織',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_api_error_log'
GO

-- ----------------------------
-- Table structure for infra_codegen_column
-- ----------------------------
DROP TABLE IF EXISTS infra_codegen_column
GO
CREATE TABLE infra_codegen_column
(
    id                       bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    table_id                 bigint                                  NOT NULL,
    column_name              nvarchar(200)                           NOT NULL,
    data_type                nvarchar(100)                           NOT NULL,
    column_comment           nvarchar(500)                           NOT NULL,
    nullable                 varchar(1)                              NOT NULL,
    primary_key              varchar(1)                              NOT NULL,
    ordinal_position         int                                     NOT NULL,
    java_type                nvarchar(32)                            NOT NULL,
    java_field               nvarchar(64)                            NOT NULL,
    dict_type                nvarchar(200) DEFAULT ''                NULL,
    example                  nvarchar(64)  DEFAULT NULL              NULL,
    create_operation         varchar(1)                              NOT NULL,
    update_operation         varchar(1)                              NOT NULL,
    list_operation           varchar(1)                              NOT NULL,
    list_operation_condition nvarchar(32)  DEFAULT '='               NOT NULL,
    list_operation_result    varchar(1)                              NOT NULL,
    html_type                nvarchar(32)                            NOT NULL,
    creator                  nvarchar(64)  DEFAULT ''                NULL,
    create_time              datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater                  nvarchar(64)  DEFAULT ''                NULL,
    update_time              datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted                  bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'琛ㄧ紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'table_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楁鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'column_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楁绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'data_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楁鎻忚堪',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'column_comment'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍏佽涓虹┖',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'nullable'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁涓婚敭',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'primary_key'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎺掑簭',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'ordinal_position'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'Java 灞炴€х被鍨?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'java_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'Java 灞炴€у悕',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'java_field'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楀吀绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'dict_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏁版嵁绀轰緥',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'example'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁涓?Create 鍒涘缓鎿嶄綔鐨勫瓧娈?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'create_operation'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁涓?Update 鏇存柊鎿嶄綔鐨勫瓧娈?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'update_operation'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁涓?List 鏌ヨ鎿嶄綔鐨勫瓧娈?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'list_operation'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'List 鏌ヨ鎿嶄綔鐨勬潯浠剁被鍨?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'list_operation_condition'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁涓?List 鏌ヨ鎿嶄綔鐨勮繑鍥炲瓧娈?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'list_operation_result'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄剧ず绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'html_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'浠ｇ爜鐢熸垚琛ㄥ瓧娈靛畾涔?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_column'
GO

-- ----------------------------
-- Table structure for infra_codegen_table
-- ----------------------------
DROP TABLE IF EXISTS infra_codegen_table
GO
CREATE TABLE infra_codegen_table
(
    id                    bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    data_source_config_id bigint                                  NOT NULL,
    scene                 tinyint       DEFAULT 1                 NOT NULL,
    table_name            nvarchar(200) DEFAULT ''                NOT NULL,
    table_comment         nvarchar(500) DEFAULT ''                NOT NULL,
    remark                nvarchar(500) DEFAULT NULL              NULL,
    module_name           nvarchar(30)                            NOT NULL,
    business_name         nvarchar(30)                            NOT NULL,
    class_name            nvarchar(100) DEFAULT ''                NOT NULL,
    class_comment         nvarchar(50)                            NOT NULL,
    author                nvarchar(50)                            NOT NULL,
    template_type         tinyint       DEFAULT 1                 NOT NULL,
    front_type            tinyint                                 NOT NULL,
    parent_menu_id        bigint        DEFAULT NULL              NULL,
    master_table_id       bigint        DEFAULT NULL              NULL,
    sub_join_column_id    bigint        DEFAULT NULL              NULL,
    sub_join_many         varchar(1)    DEFAULT NULL              NULL,
    tree_parent_column_id bigint        DEFAULT NULL              NULL,
    tree_name_column_id   bigint        DEFAULT NULL              NULL,
    creator               nvarchar(64)  DEFAULT ''                NULL,
    create_time           datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater               nvarchar(64)  DEFAULT ''                NULL,
    update_time           datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted               bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏁版嵁婧愰厤缃殑缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'data_source_config_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢熸垚鍦烘櫙',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'scene'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'琛ㄥ悕绉?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'table_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'琛ㄦ弿杩?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'table_comment'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶囨敞',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯″潡鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'module_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'涓氬姟鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'business_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绫诲悕绉?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'class_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绫绘弿杩?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'class_comment'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'浣滆€?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'author'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'template_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍓嶇绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'front_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐖惰彍鍗曠紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'parent_menu_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'涓昏〃鐨勭紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'master_table_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛愯〃鍏宠仈涓昏〃鐨勫瓧娈电紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'sub_join_column_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'涓昏〃涓庡瓙琛ㄦ槸鍚︿竴瀵瑰',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'sub_join_many'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏍戣〃鐨勭埗瀛楁缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'tree_parent_column_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏍戣〃鐨勫悕瀛楀瓧娈电紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'tree_name_column_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'浠ｇ爜鐢熸垚琛ㄥ畾涔?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_codegen_table'
GO

-- ----------------------------
-- Table structure for infra_config
-- ----------------------------
DROP TABLE IF EXISTS infra_config
GO
CREATE TABLE infra_config
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    category    nvarchar(50)                            NOT NULL,
    type        tinyint                                 NOT NULL,
    name        nvarchar(100) DEFAULT ''                NOT NULL,
    config_key  nvarchar(100) DEFAULT ''                NOT NULL,
    value       nvarchar(500) DEFAULT ''                NOT NULL,
    visible     varchar(1)                              NOT NULL,
    remark      nvarchar(500) DEFAULT NULL              NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙傛暟涓婚敭',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙傛暟鍒嗙粍',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config',
     'COLUMN', N'category'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙傛暟绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config',
     'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙傛暟鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙傛暟閿悕',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config',
     'COLUMN', N'config_key'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙傛暟閿€?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config',
     'COLUMN', N'value'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍙',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config',
     'COLUMN', N'visible'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶囨敞',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config',
     'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙傛暟閰嶇疆琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_config'
GO

-- ----------------------------
-- Records of infra_config
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT infra_config ON
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (2, N'biz', 1, N'鐢ㄦ埛绠＄悊-璐﹀彿鍒濆瀵嗙爜', N'system.user.init-password', N'123456', N'0', N'鍒濆鍖栧瘑鐮?123456', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-07-20 17:22:47', N'0')
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (7, N'url', 2, N'MySQL 鐩戞帶鐨勫湴鍧€', N'url.druid', N'', N'1', N'', N'1', N'2023-04-07 13:41:16', N'1', N'2023-04-07 14:33:38', N'0')
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (8, N'url', 2, N'SkyWalking 鐩戞帶鐨勫湴鍧€', N'url.skywalking', N'', N'1', N'', N'1', N'2023-04-07 13:41:16', N'1', N'2023-04-07 14:57:03', N'0')
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (9, N'url', 2, N'Spring Boot Admin 鐩戞帶鐨勫湴鍧€', N'url.spring-boot-admin', N'', N'1', N'', N'1', N'2023-04-07 13:41:16', N'1', N'2023-04-07 14:52:07', N'0')
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (10, N'url', 2, N'Swagger 鎺ュ彛鏂囨。鐨勫湴鍧€', N'url.swagger', N'', N'1', N'', N'1', N'2023-04-07 13:41:16', N'1', N'2023-04-07 14:59:00', N'0')
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (11, N'ui', 2, N'鑵捐鍦板浘 key', N'tencent.lbs.key', N'TVDBZ-TDILD-4ON4B-PFDZA-RNLKH-VVF6E', N'1', N'鑵捐鍦板浘 key', N'1', N'2023-06-03 19:16:27', N'1', N'2023-06-03 19:16:27', N'0')
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (12, N'test2', 2, N'test3', N'test4', N'test5', N'1', N'test6', N'1', N'2023-12-03 09:55:16', N'1', N'2025-04-06 21:00:09', N'0')
GO
INSERT INTO infra_config (id, category, type, name, config_key, value, visible, remark, creator, create_time, updater, update_time, deleted) VALUES (13, N'鐢ㄦ埛绠＄悊-璐﹀彿鍒濆瀵嗙爜', 2, N'鐢ㄦ埛绠＄悊-娉ㄥ唽寮€鍏?, N'system.user.register-enabled', N'true', N'0', N'', N'1', N'2025-04-26 17:23:41', N'1', N'2025-04-26 17:23:41', N'0')
GO
SET IDENTITY_INSERT infra_config OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for infra_data_source_config
-- ----------------------------
DROP TABLE IF EXISTS infra_data_source_config
GO
CREATE TABLE infra_data_source_config
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name        nvarchar(100) DEFAULT ''                NOT NULL,
    url         nvarchar(1024)                          NOT NULL,
    username    nvarchar(255)                           NOT NULL,
    password    nvarchar(255) DEFAULT ''                NOT NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'涓婚敭缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_data_source_config',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙傛暟鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_data_source_config',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏁版嵁婧愯繛鎺?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_data_source_config',
     'COLUMN', N'url'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_data_source_config',
     'COLUMN', N'username'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀵嗙爜',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_data_source_config',
     'COLUMN', N'password'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_data_source_config',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_data_source_config',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_data_source_config',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_data_source_config',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_data_source_config',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏁版嵁婧愰厤缃〃',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_data_source_config'
GO

-- ----------------------------
-- Table structure for infra_file
-- ----------------------------
DROP TABLE IF EXISTS infra_file
GO
CREATE TABLE infra_file
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    config_id   bigint        DEFAULT NULL              NULL,
    name        nvarchar(256) DEFAULT NULL              NULL,
    path        nvarchar(512)                           NOT NULL,
    url         nvarchar(1024)                          NOT NULL,
    type        nvarchar(128) DEFAULT NULL              NULL,
    size        int                                     NOT NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏂囦欢缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閰嶇疆缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file',
     'COLUMN', N'config_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏂囦欢鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏂囦欢璺緞',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file',
     'COLUMN', N'path'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏂囦欢 URL',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file',
     'COLUMN', N'url'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏂囦欢绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file',
     'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏂囦欢澶у皬',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file',
     'COLUMN', N'size'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏂囦欢琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file'
GO

-- ----------------------------
-- Table structure for infra_file_config
-- ----------------------------
DROP TABLE IF EXISTS infra_file_config
GO
CREATE TABLE infra_file_config
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name        nvarchar(63)                            NOT NULL,
    storage     tinyint                                 NOT NULL,
    remark      nvarchar(255) DEFAULT NULL              NULL,
    master      varchar(1)                              NOT NULL,
    config      nvarchar(4000)                          NOT NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_config',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閰嶇疆鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_config',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛樺偍鍣?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_config',
     'COLUMN', N'storage'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶囨敞',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_config',
     'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁涓轰富閰嶇疆',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_config',
     'COLUMN', N'master'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛樺偍閰嶇疆',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_config',
     'COLUMN', N'config'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_config',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_config',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_config',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_config',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_config',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏂囦欢閰嶇疆琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_config'
GO

-- ----------------------------
-- Records of infra_file_config
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT infra_file_config ON
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (4, N'鏁版嵁搴擄紙绀轰緥锛?, 1, N'鎴戞槸鏁版嵁搴?, N'0', N'{"@class":"cn.iocoder.yudao.module.infra.framework.file.core.client.db.DBFileClientConfig","domain":"http://127.0.0.1:48080"}', N'1', N'2022-03-15 23:56:24', N'1', N'2025-05-02 18:30:28', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (22, N'涓冪墰瀛樺偍鍣紙绀轰緥锛?, 20, N'璇锋崲鎴愪綘鑷繁鐨勫瘑閽ワ紒锛侊紒', N'1', N'{"@class":"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"s3.cn-south-1.qiniucs.com","domain":"http://test.yudao.iocoder.cn","bucket":"ruoyi-vue-pro","accessKey":"QINIU_ACCESS_KEY_PLACEHOLDER","accessSecret":"QINIU_ACCESS_SECRET_PLACEHOLDER","enablePathStyleAccess":false}', N'1', N'2024-01-13 22:11:12', N'1', N'2025-05-02 18:30:28', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (24, N'鑵捐浜戝瓨鍌紙绀轰緥锛?, 20, N'璇锋崲鎴愪綘鐨勫瘑閽ワ紒锛侊紒', N'0', N'{"@class":"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"https://cos.ap-shanghai.myqcloud.com","domain":"http://tengxun-oss.iocoder.cn","bucket":"aoteman-1255880240","accessKey":"TENCENT_ACCESS_KEY_PLACEHOLDER","accessSecret":"X"}', N'1', N'2024-11-09 16:03:22', N'1', N'2025-05-02 18:30:28', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (25, N'闃块噷浜戝瓨鍌紙绀轰緥锛?, 20, N'', N'0', N'{"@class":"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"oss-cn-beijing.aliyuncs.com","domain":"http://ali-oss.iocoder.cn","bucket":"yunai-aoteman","accessKey":"ALIYUN_ACCESS_KEY_PLACEHOLDER","accessSecret":"X","enablePathStyleAccess":false}', N'1', N'2024-11-09 16:47:08', N'1', N'2025-05-02 18:30:28', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (26, N'鐏北浜戝瓨鍌紙绀轰緥锛?, 20, N'', N'0', N'{"@class":"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"tos-s3-cn-beijing.volces.com","domain":null,"bucket":"yunai","accessKey":"VOLCENGINE_ACCESS_KEY_PLACEHOLDER","accessSecret":"X==","enablePathStyleAccess":false}', N'1', N'2024-11-09 16:56:42', N'1', N'2025-05-02 18:30:28', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (27, N'鍗庝负浜戝瓨鍌紙绀轰緥锛?, 20, N'', N'0', N'{"@class":"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"obs.cn-east-3.myhuaweicloud.com","domain":"","bucket":"yudao","accessKey":"HUAWEI_ACCESS_KEY_PLACEHOLDER","accessSecret":"X","enablePathStyleAccess":false}', N'1', N'2024-11-09 17:18:41', N'1', N'2025-05-02 18:30:28', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (28, N'MinIO 瀛樺偍锛堢ず渚嬶級', 20, N'', N'0', N'{"@class":"cn.iocoder.yudao.module.infra.framework.file.core.client.s3.S3FileClientConfig","endpoint":"http://127.0.0.1:9000","domain":"http://127.0.0.1:9000/yudao","bucket":"yudao","accessKey":"admin","accessSecret":"password","enablePathStyleAccess":false}', N'1', N'2024-11-09 17:43:10', N'1', N'2025-05-02 18:30:28', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (29, N'鏈湴瀛樺偍锛堢ず渚嬶級', 10, N'浠呴€傚悎 mac 鎴?windows', N'0', N'{"@class":"cn.iocoder.yudao.module.infra.framework.file.core.client.local.LocalFileClientConfig","basePath":"/Users/yunai/tmp/file","domain":"http://127.0.0.1:48080"}', N'1', N'2025-05-02 11:25:45', N'1', N'2025-05-02 18:30:28', N'0')
GO
INSERT INTO infra_file_config (id, name, storage, remark, master, config, creator, create_time, updater, update_time, deleted) VALUES (30, N'SFTP 瀛樺偍锛堢ず渚嬶級', 12, N'', N'0', N'{"@class":"cn.iocoder.yudao.module.infra.framework.file.core.client.sftp.SftpFileClientConfig","basePath":"/upload","domain":"http://127.0.0.1:48080","host":"127.0.0.1","port":2222,"username":"foo","password":"pass"}', N'1', N'2025-05-02 16:34:10', N'1', N'2025-05-02 18:30:28', N'0')
GO
SET IDENTITY_INSERT infra_file_config OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for infra_file_content
-- ----------------------------
DROP TABLE IF EXISTS infra_file_content
GO
CREATE TABLE infra_file_content
(
    id          bigint                                 NOT NULL PRIMARY KEY IDENTITY,
    config_id   bigint                                 NOT NULL,
    path        nvarchar(512)                          NOT NULL,
    content     varbinary(max)                         NOT NULL,
    creator     nvarchar(64) DEFAULT ''                NULL,
    create_time datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64) DEFAULT ''                NULL,
    update_time datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit          DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_content',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閰嶇疆缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_content',
     'COLUMN', N'config_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏂囦欢璺緞',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_content',
     'COLUMN', N'path'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏂囦欢鍐呭',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_content',
     'COLUMN', N'content'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_content',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_content',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_content',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_content',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_content',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏂囦欢琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_file_content'
GO

-- ----------------------------
-- Table structure for infra_job
-- ----------------------------
DROP TABLE IF EXISTS infra_job
GO
CREATE TABLE infra_job
(
    id              bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name            nvarchar(32)                            NOT NULL,
    status          tinyint                                 NOT NULL,
    handler_name    nvarchar(64)                            NOT NULL,
    handler_param   nvarchar(255) DEFAULT NULL              NULL,
    cron_expression nvarchar(32)                            NOT NULL,
    retry_count     int           DEFAULT 0                 NOT NULL,
    retry_interval  int           DEFAULT 0                 NOT NULL,
    monitor_timeout int           DEFAULT 0                 NOT NULL,
    creator         nvarchar(64)  DEFAULT ''                NULL,
    create_time     datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater         nvarchar(64)  DEFAULT ''                NULL,
    update_time     datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted         bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'浠诲姟缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'浠诲姟鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'浠诲姟鐘舵€?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶勭悊鍣ㄧ殑鍚嶅瓧',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'handler_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶勭悊鍣ㄧ殑鍙傛暟',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'handler_param'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'CRON 琛ㄨ揪寮?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'cron_expression'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閲嶈瘯娆℃暟',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'retry_count'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閲嶈瘯闂撮殧',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'retry_interval'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐩戞帶瓒呮椂鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'monitor_timeout'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀹氭椂浠诲姟琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job'
GO

-- ----------------------------
-- Records of infra_job
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT infra_job ON
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (5, N'鏀粯閫氱煡 Job', 2, N'payNotifyJob', NULL, N'* * * * * ?', 0, 0, 0, N'1', N'2021-10-27 08:34:42', N'1', N'2024-09-12 13:32:48', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (17, N'鏀粯璁㈠崟鍚屾 Job', 2, N'payOrderSyncJob', NULL, N'0 0/1 * * * ?', 0, 0, 0, N'1', N'2023-07-22 14:36:26', N'1', N'2023-07-22 15:39:08', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (18, N'鏀粯璁㈠崟杩囨湡 Job', 2, N'payOrderExpireJob', NULL, N'0 0/1 * * * ?', 0, 0, 0, N'1', N'2023-07-22 15:36:23', N'1', N'2023-07-22 15:39:54', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (19, N'閫€娆捐鍗曠殑鍚屾 Job', 2, N'payRefundSyncJob', NULL, N'0 0/1 * * * ?', 0, 0, 0, N'1', N'2023-07-23 21:03:44', N'1', N'2023-07-23 21:09:00', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (21, N'浜ゆ槗璁㈠崟鐨勮嚜鍔ㄨ繃鏈?Job', 2, N'tradeOrderAutoCancelJob', N'', N'0 * * * * ?', 3, 0, 0, N'1', N'2023-09-25 23:43:26', N'1', N'2023-09-26 19:23:30', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (22, N'浜ゆ槗璁㈠崟鐨勮嚜鍔ㄦ敹璐?Job', 2, N'tradeOrderAutoReceiveJob', N'', N'0 * * * * ?', 3, 0, 0, N'1', N'2023-09-26 19:23:53', N'1', N'2023-09-26 23:38:08', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (23, N'浜ゆ槗璁㈠崟鐨勮嚜鍔ㄨ瘎璁?Job', 2, N'tradeOrderAutoCommentJob', N'', N'0 * * * * ?', 3, 0, 0, N'1', N'2023-09-26 23:38:29', N'1', N'2023-09-27 11:03:10', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (24, N'浣ｉ噾瑙ｅ喕 Job', 2, N'brokerageRecordUnfreezeJob', N'', N'0 * * * * ?', 3, 0, 0, N'1', N'2023-09-28 22:01:46', N'1', N'2023-09-28 22:01:56', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (25, N'璁块棶鏃ュ織娓呯悊 Job', 2, N'accessLogCleanJob', N'', N'0 0 0 * * ?', 3, 0, 0, N'1', N'2023-10-03 10:59:41', N'1', N'2023-10-03 11:01:10', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (26, N'閿欒鏃ュ織娓呯悊 Job', 2, N'errorLogCleanJob', N'', N'0 0 0 * * ?', 3, 0, 0, N'1', N'2023-10-03 11:00:43', N'1', N'2023-10-03 11:01:12', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (27, N'浠诲姟鏃ュ織娓呯悊 Job', 2, N'jobLogCleanJob', N'', N'0 0 0 * * ?', 3, 0, 0, N'1', N'2023-10-03 11:01:33', N'1', N'2024-09-12 13:40:34', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (33, N'demoJob', 2, N'demoJob', N'', N'0 * * * * ?', 1, 1, 0, N'1', N'2024-10-27 19:38:46', N'1', N'2025-05-10 18:13:54', N'0')
GO
INSERT INTO infra_job (id, name, status, handler_name, handler_param, cron_expression, retry_count, retry_interval, monitor_timeout, creator, create_time, updater, update_time, deleted) VALUES (35, N'杞处璁㈠崟鐨勫悓姝?Job', 2, N'payTransferSyncJob', N'', N'0 * * * * ?', 0, 0, 0, N'1', N'2025-05-10 17:35:54', N'1', N'2025-05-10 18:13:52', N'0')
GO
SET IDENTITY_INSERT infra_job OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for infra_job_log
-- ----------------------------
DROP TABLE IF EXISTS infra_job_log
GO
CREATE TABLE infra_job_log
(
    id            bigint                                   NOT NULL PRIMARY KEY IDENTITY,
    job_id        bigint                                   NOT NULL,
    handler_name  nvarchar(64)                             NOT NULL,
    handler_param nvarchar(255)  DEFAULT NULL              NULL,
    execute_index tinyint        DEFAULT 1                 NOT NULL,
    begin_time    datetime2                                NOT NULL,
    end_time      datetime2      DEFAULT NULL              NULL,
    duration      int            DEFAULT NULL              NULL,
    status        tinyint                                  NOT NULL,
    result        nvarchar(4000) DEFAULT ''                NULL,
    creator       nvarchar(64)   DEFAULT ''                NULL,
    create_time   datetime2      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater       nvarchar(64)   DEFAULT ''                NULL,
    update_time   datetime2      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted       bit            DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏃ュ織缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'浠诲姟缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'job_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶勭悊鍣ㄧ殑鍚嶅瓧',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'handler_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶勭悊鍣ㄧ殑鍙傛暟',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'handler_param'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绗嚑娆℃墽琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'execute_index'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮€濮嬫墽琛屾椂闂?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'begin_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缁撴潫鎵ц鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'end_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎵ц鏃堕暱',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'duration'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'浠诲姟鐘舵€?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缁撴灉鏁版嵁',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'result'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀹氭椂浠诲姟鏃ュ織琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'infra_job_log'
GO

-- ----------------------------
-- Table structure for system_dept
-- ----------------------------
DROP TABLE IF EXISTS system_dept
GO
CREATE TABLE system_dept
(
    id             bigint                                 NOT NULL PRIMARY KEY IDENTITY,
    name           nvarchar(30) DEFAULT ''                NOT NULL,
    parent_id      bigint       DEFAULT 0                 NOT NULL,
    sort           int          DEFAULT 0                 NOT NULL,
    leader_user_id bigint       DEFAULT NULL              NULL,
    phone          nvarchar(11) DEFAULT NULL              NULL,
    email          nvarchar(50) DEFAULT NULL              NULL,
    status         tinyint                                NOT NULL,
    creator        nvarchar(64) DEFAULT ''                NULL,
    create_time    datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater        nvarchar(64) DEFAULT ''                NULL,
    update_time    datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted        bit          DEFAULT 0                 NOT NULL,
    tenant_id      bigint       DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閮ㄩ棬id',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閮ㄩ棬鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐖堕儴闂╥d',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'parent_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄剧ず椤哄簭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'sort'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璐熻矗浜?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'leader_user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑱旂郴鐢佃瘽',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'phone'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'email'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閮ㄩ棬鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閮ㄩ棬琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dept'
GO

-- ----------------------------
-- Records of system_dept
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_dept ON
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (100, N'鑺嬮亾婧愮爜', 0, 0, 1, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'1', N'2025-03-29 15:47:53', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (101, N'娣卞湷鎬诲叕鍙?, 100, 1, 104, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'1', N'2025-03-29 15:49:55', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (102, N'闀挎矙鍒嗗叕鍙?, 100, 2, NULL, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'', N'2021-12-15 05:01:40', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (103, N'鐮斿彂閮ㄩ棬', 101, 1, 1, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'1', N'2024-10-02 10:22:03', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (104, N'甯傚満閮ㄩ棬', 101, 2, NULL, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'', N'2021-12-15 05:01:38', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (105, N'娴嬭瘯閮ㄩ棬', 101, 3, NULL, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'1', N'2022-05-16 20:25:15', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (106, N'璐㈠姟閮ㄩ棬', 101, 4, 103, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'103', N'2022-01-15 21:32:22', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (107, N'杩愮淮閮ㄩ棬', 101, 5, 1, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'1', N'2023-12-02 09:28:22', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (108, N'甯傚満閮ㄩ棬', 102, 1, NULL, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'1', N'2022-02-16 08:35:45', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (109, N'璐㈠姟閮ㄩ棬', 102, 2, NULL, N'15888888888', N'ry@qq.com', 0, N'admin', N'2021-01-05 17:03:47', N'', N'2021-12-15 05:01:29', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (110, N'鏂伴儴闂?, 0, 1, NULL, NULL, NULL, 0, N'110', N'2022-02-23 20:46:30', N'110', N'2022-02-23 20:46:30', N'0', 121)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (111, N'椤剁骇閮ㄩ棬', 0, 1, NULL, NULL, NULL, 0, N'113', N'2022-03-07 21:44:50', N'113', N'2022-03-07 21:44:50', N'0', 122)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (112, N'浜у搧閮ㄩ棬', 101, 100, 1, NULL, NULL, 1, N'1', N'2023-12-02 09:45:13', N'1', N'2023-12-02 09:45:31', N'0', 1)
GO
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (113, N'鏀寔閮ㄩ棬', 102, 3, 104, NULL, NULL, 1, N'1', N'2023-12-02 09:47:38', N'1', N'2025-03-29 15:00:56', N'0', 1)
GO
SET IDENTITY_INSERT system_dept OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_dict_data
-- ----------------------------
DROP TABLE IF EXISTS system_dict_data
GO
CREATE TABLE system_dict_data
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    sort        int           DEFAULT 0                 NOT NULL,
    label       nvarchar(100) DEFAULT ''                NOT NULL,
    value       nvarchar(100) DEFAULT ''                NOT NULL,
    dict_type   nvarchar(100) DEFAULT ''                NOT NULL,
    status      tinyint       DEFAULT 0                 NOT NULL,
    color_type  nvarchar(100) DEFAULT ''                NULL,
    css_class   nvarchar(100) DEFAULT ''                NULL,
    remark      nvarchar(500) DEFAULT NULL              NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楀吀缂栫爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楀吀鎺掑簭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'sort'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楀吀鏍囩',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'label'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楀吀閿€?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'value'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楀吀绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'dict_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'棰滆壊绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'color_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'css 鏍峰紡',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'css_class'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶囨敞',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楀吀鏁版嵁琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_data'
GO

-- ----------------------------
-- Records of system_dict_data
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_dict_data ON
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1, 1, N'鐢?, N'1', N'system_user_sex', 0, N'default', N'A', N'鎬у埆鐢?, N'admin', N'2021-01-05 17:03:48', N'1', N'2022-03-29 00:14:39', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2, 2, N'濂?, N'2', N'system_user_sex', 0, N'success', N'', N'鎬у埆濂?, N'admin', N'2021-01-05 17:03:48', N'1', N'2023-11-15 23:30:37', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (8, 1, N'姝ｅ父', N'1', N'infra_job_status', 0, N'success', N'', N'姝ｅ父鐘舵€?, N'admin', N'2021-01-05 17:03:48', N'1', N'2022-02-16 19:33:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (9, 2, N'鏆傚仠', N'2', N'infra_job_status', 0, N'danger', N'', N'鍋滅敤鐘舵€?, N'admin', N'2021-01-05 17:03:48', N'1', N'2022-02-16 19:33:45', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (12, 1, N'绯荤粺鍐呯疆', N'1', N'infra_config_type', 0, N'danger', N'', N'鍙傛暟绫诲瀷 - 绯荤粺鍐呯疆', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-02-16 19:06:02', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (13, 2, N'鑷畾涔?, N'2', N'infra_config_type', 0, N'primary', N'', N'鍙傛暟绫诲瀷 - 鑷畾涔?, N'admin', N'2021-01-05 17:03:48', N'1', N'2022-02-16 19:06:07', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (14, 1, N'閫氱煡', N'1', N'system_notice_type', 0, N'success', N'', N'閫氱煡', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-02-16 13:05:57', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (15, 2, N'鍏憡', N'2', N'system_notice_type', 0, N'info', N'', N'鍏憡', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-02-16 13:06:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (16, 0, N'鍏跺畠', N'0', N'infra_operate_type', 0, N'default', N'', N'鍏跺畠鎿嶄綔', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-03-14 12:44:19', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (17, 1, N'鏌ヨ', N'1', N'infra_operate_type', 0, N'info', N'', N'鏌ヨ鎿嶄綔', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-03-14 12:44:20', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (18, 2, N'鏂板', N'2', N'infra_operate_type', 0, N'primary', N'', N'鏂板鎿嶄綔', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-03-14 12:44:21', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (19, 3, N'淇敼', N'3', N'infra_operate_type', 0, N'warning', N'', N'淇敼鎿嶄綔', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-03-14 12:44:22', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (20, 4, N'鍒犻櫎', N'4', N'infra_operate_type', 0, N'danger', N'', N'鍒犻櫎鎿嶄綔', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-03-14 12:44:23', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (22, 5, N'瀵煎嚭', N'5', N'infra_operate_type', 0, N'default', N'', N'瀵煎嚭鎿嶄綔', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-03-14 12:44:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (23, 6, N'瀵煎叆', N'6', N'infra_operate_type', 0, N'default', N'', N'瀵煎叆鎿嶄綔', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-03-14 12:44:25', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (27, 1, N'寮€鍚?, N'0', N'common_status', 0, N'primary', N'', N'寮€鍚姸鎬?, N'admin', N'2021-01-05 17:03:48', N'1', N'2022-02-16 08:00:39', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (28, 2, N'鍏抽棴', N'1', N'common_status', 0, N'info', N'', N'鍏抽棴鐘舵€?, N'admin', N'2021-01-05 17:03:48', N'1', N'2022-02-16 08:00:44', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (29, 1, N'鐩綍', N'1', N'system_menu_type', 0, N'', N'', N'鐩綍', N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:43:45', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (30, 2, N'鑿滃崟', N'2', N'system_menu_type', 0, N'', N'', N'鑿滃崟', N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:43:41', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (31, 3, N'鎸夐挳', N'3', N'system_menu_type', 0, N'', N'', N'鎸夐挳', N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:43:39', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (32, 1, N'鍐呯疆', N'1', N'system_role_type', 0, N'danger', N'', N'鍐呯疆瑙掕壊', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-02-16 13:02:08', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (33, 2, N'鑷畾涔?, N'2', N'system_role_type', 0, N'primary', N'', N'鑷畾涔夎鑹?, N'admin', N'2021-01-05 17:03:48', N'1', N'2022-02-16 13:02:12', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (34, 1, N'鍏ㄩ儴鏁版嵁鏉冮檺', N'1', N'system_data_scope', 0, N'', N'', N'鍏ㄩ儴鏁版嵁鏉冮檺', N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:47:17', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (35, 2, N'鎸囧畾閮ㄩ棬鏁版嵁鏉冮檺', N'2', N'system_data_scope', 0, N'', N'', N'鎸囧畾閮ㄩ棬鏁版嵁鏉冮檺', N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:47:18', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (36, 3, N'鏈儴闂ㄦ暟鎹潈闄?, N'3', N'system_data_scope', 0, N'', N'', N'鏈儴闂ㄦ暟鎹潈闄?, N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:47:16', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (37, 4, N'鏈儴闂ㄥ強浠ヤ笅鏁版嵁鏉冮檺', N'4', N'system_data_scope', 0, N'', N'', N'鏈儴闂ㄥ強浠ヤ笅鏁版嵁鏉冮檺', N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:47:21', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (38, 5, N'浠呮湰浜烘暟鎹潈闄?, N'5', N'system_data_scope', 0, N'', N'', N'浠呮湰浜烘暟鎹潈闄?, N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:47:23', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (39, 0, N'鎴愬姛', N'0', N'system_login_result', 0, N'success', N'', N'鐧婚檰缁撴灉 - 鎴愬姛', N'', N'2021-01-18 06:17:36', N'1', N'2022-02-16 13:23:49', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (40, 10, N'璐﹀彿鎴栧瘑鐮佷笉姝ｇ‘', N'10', N'system_login_result', 0, N'primary', N'', N'鐧婚檰缁撴灉 - 璐﹀彿鎴栧瘑鐮佷笉姝ｇ‘', N'', N'2021-01-18 06:17:54', N'1', N'2022-02-16 13:24:27', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (41, 20, N'鐢ㄦ埛琚鐢?, N'20', N'system_login_result', 0, N'warning', N'', N'鐧婚檰缁撴灉 - 鐢ㄦ埛琚鐢?, N'', N'2021-01-18 06:17:54', N'1', N'2022-02-16 13:23:57', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (42, 30, N'楠岃瘉鐮佷笉瀛樺湪', N'30', N'system_login_result', 0, N'info', N'', N'鐧婚檰缁撴灉 - 楠岃瘉鐮佷笉瀛樺湪', N'', N'2021-01-18 06:17:54', N'1', N'2022-02-16 13:24:07', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (43, 31, N'楠岃瘉鐮佷笉姝ｇ‘', N'31', N'system_login_result', 0, N'info', N'', N'鐧婚檰缁撴灉 - 楠岃瘉鐮佷笉姝ｇ‘', N'', N'2021-01-18 06:17:54', N'1', N'2022-02-16 13:24:11', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (44, 100, N'鏈煡寮傚父', N'100', N'system_login_result', 0, N'danger', N'', N'鐧婚檰缁撴灉 - 鏈煡寮傚父', N'', N'2021-01-18 06:17:54', N'1', N'2022-02-16 13:24:23', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (45, 1, N'鏄?, N'true', N'infra_boolean_string', 0, N'danger', N'', N'Boolean 鏄惁绫诲瀷 - 鏄?, N'', N'2021-01-19 03:20:55', N'1', N'2022-03-15 23:01:45', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (46, 1, N'鍚?, N'false', N'infra_boolean_string', 0, N'info', N'', N'Boolean 鏄惁绫诲瀷 - 鍚?, N'', N'2021-01-19 03:20:55', N'1', N'2022-03-15 23:09:45', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (50, 1, N'鍗曡〃锛堝鍒犳敼鏌ワ級', N'1', N'infra_codegen_template_type', 0, N'', N'', NULL, N'', N'2021-02-05 07:09:06', N'', N'2022-03-10 16:33:15', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (51, 2, N'鏍戣〃锛堝鍒犳敼鏌ワ級', N'2', N'infra_codegen_template_type', 0, N'', N'', NULL, N'', N'2021-02-05 07:14:46', N'', N'2022-03-10 16:33:19', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (53, 0, N'鍒濆鍖栦腑', N'0', N'infra_job_status', 0, N'primary', N'', NULL, N'', N'2021-02-07 07:46:49', N'1', N'2022-02-16 19:33:29', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (57, 0, N'杩愯涓?, N'0', N'infra_job_log_status', 0, N'primary', N'', N'RUNNING', N'', N'2021-02-08 10:04:24', N'1', N'2022-02-16 19:07:48', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (58, 1, N'鎴愬姛', N'1', N'infra_job_log_status', 0, N'success', N'', NULL, N'', N'2021-02-08 10:06:57', N'1', N'2022-02-16 19:07:52', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (59, 2, N'澶辫触', N'2', N'infra_job_log_status', 0, N'warning', N'', N'澶辫触', N'', N'2021-02-08 10:07:38', N'1', N'2022-02-16 19:07:56', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (60, 1, N'浼氬憳', N'1', N'user_type', 0, N'primary', N'', NULL, N'', N'2021-02-26 00:16:27', N'1', N'2022-02-16 10:22:19', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (61, 2, N'绠＄悊鍛?, N'2', N'user_type', 0, N'success', N'', NULL, N'', N'2021-02-26 00:16:34', N'1', N'2025-04-06 18:37:43', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (62, 0, N'鏈鐞?, N'0', N'infra_api_error_log_process_status', 0, N'primary', N'', NULL, N'', N'2021-02-26 07:07:19', N'1', N'2022-02-16 20:14:17', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (63, 1, N'宸插鐞?, N'1', N'infra_api_error_log_process_status', 0, N'success', N'', NULL, N'', N'2021-02-26 07:07:26', N'1', N'2022-02-16 20:14:08', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (64, 2, N'宸插拷鐣?, N'2', N'infra_api_error_log_process_status', 0, N'danger', N'', NULL, N'', N'2021-02-26 07:07:34', N'1', N'2022-02-16 20:14:14', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (66, 1, N'闃块噷浜?, N'ALIYUN', N'system_sms_channel_code', 0, N'primary', N'', NULL, N'1', N'2021-04-05 01:05:26', N'1', N'2024-07-22 22:23:25', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (67, 1, N'楠岃瘉鐮?, N'1', N'system_sms_template_type', 0, N'warning', N'', NULL, N'1', N'2021-04-05 21:50:57', N'1', N'2022-02-16 12:48:30', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (68, 2, N'閫氱煡', N'2', N'system_sms_template_type', 0, N'primary', N'', NULL, N'1', N'2021-04-05 21:51:08', N'1', N'2022-02-16 12:48:27', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (69, 0, N'钀ラ攢', N'3', N'system_sms_template_type', 0, N'danger', N'', NULL, N'1', N'2021-04-05 21:51:15', N'1', N'2022-02-16 12:48:22', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (70, 0, N'鍒濆鍖?, N'0', N'system_sms_send_status', 0, N'primary', N'', NULL, N'1', N'2021-04-11 20:18:33', N'1', N'2022-02-16 10:26:07', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (71, 1, N'鍙戦€佹垚鍔?, N'10', N'system_sms_send_status', 0, N'success', N'', NULL, N'1', N'2021-04-11 20:18:43', N'1', N'2022-02-16 10:25:56', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (72, 2, N'鍙戦€佸け璐?, N'20', N'system_sms_send_status', 0, N'danger', N'', NULL, N'1', N'2021-04-11 20:18:49', N'1', N'2022-02-16 10:26:03', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (73, 3, N'涓嶅彂閫?, N'30', N'system_sms_send_status', 0, N'info', N'', NULL, N'1', N'2021-04-11 20:19:44', N'1', N'2022-02-16 10:26:10', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (74, 0, N'绛夊緟缁撴灉', N'0', N'system_sms_receive_status', 0, N'primary', N'', NULL, N'1', N'2021-04-11 20:27:43', N'1', N'2022-02-16 10:28:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (75, 1, N'鎺ユ敹鎴愬姛', N'10', N'system_sms_receive_status', 0, N'success', N'', NULL, N'1', N'2021-04-11 20:29:25', N'1', N'2022-02-16 10:28:28', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (76, 2, N'鎺ユ敹澶辫触', N'20', N'system_sms_receive_status', 0, N'danger', N'', NULL, N'1', N'2021-04-11 20:29:31', N'1', N'2022-02-16 10:28:32', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (77, 0, N'璋冭瘯(閽夐拤)', N'DEBUG_DING_TALK', N'system_sms_channel_code', 0, N'info', N'', NULL, N'1', N'2021-04-13 00:20:37', N'1', N'2022-02-16 10:10:00', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (80, 100, N'璐﹀彿鐧诲綍', N'100', N'system_login_type', 0, N'primary', N'', N'璐﹀彿鐧诲綍', N'1', N'2021-10-06 00:52:02', N'1', N'2022-02-16 13:11:34', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (81, 101, N'绀句氦鐧诲綍', N'101', N'system_login_type', 0, N'info', N'', N'绀句氦鐧诲綍', N'1', N'2021-10-06 00:52:17', N'1', N'2022-02-16 13:11:40', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (83, 200, N'涓诲姩鐧诲嚭', N'200', N'system_login_type', 0, N'primary', N'', N'涓诲姩鐧诲嚭', N'1', N'2021-10-06 00:52:58', N'1', N'2022-02-16 13:11:49', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (85, 202, N'寮哄埗鐧诲嚭', N'202', N'system_login_type', 0, N'danger', N'', N'寮哄埗閫€鍑?, N'1', N'2021-10-06 00:53:41', N'1', N'2022-02-16 13:11:57', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (86, 0, N'鐥呭亣', N'1', N'bpm_oa_leave_type', 0, N'primary', N'', NULL, N'1', N'2021-09-21 22:35:28', N'1', N'2022-02-16 10:00:41', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (87, 1, N'浜嬪亣', N'2', N'bpm_oa_leave_type', 0, N'info', N'', NULL, N'1', N'2021-09-21 22:36:11', N'1', N'2022-02-16 10:00:49', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (88, 2, N'濠氬亣', N'3', N'bpm_oa_leave_type', 0, N'warning', N'', NULL, N'1', N'2021-09-21 22:36:38', N'1', N'2022-02-16 10:00:53', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (112, 0, N'寰俊 Wap 缃戠珯鏀粯', N'wx_wap', N'pay_channel_code', 0, N'success', N'', N'寰俊 Wap 缃戠珯鏀粯', N'1', N'2023-07-19 20:08:06', N'1', N'2023-07-19 20:09:08', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (113, 1, N'寰俊鍏紬鍙锋敮浠?, N'wx_pub', N'pay_channel_code', 0, N'success', N'', N'寰俊鍏紬鍙锋敮浠?, N'1', N'2021-12-03 10:40:24', N'1', N'2023-07-19 20:08:47', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (114, 2, N'寰俊灏忕▼搴忔敮浠?, N'wx_lite', N'pay_channel_code', 0, N'success', N'', N'寰俊灏忕▼搴忔敮浠?, N'1', N'2021-12-03 10:41:06', N'1', N'2023-07-19 20:08:50', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (115, 3, N'寰俊 App 鏀粯', N'wx_app', N'pay_channel_code', 0, N'success', N'', N'寰俊 App 鏀粯', N'1', N'2021-12-03 10:41:20', N'1', N'2023-07-19 20:08:56', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (116, 10, N'鏀粯瀹?PC 缃戠珯鏀粯', N'alipay_pc', N'pay_channel_code', 0, N'primary', N'', N'鏀粯瀹?PC 缃戠珯鏀粯', N'1', N'2021-12-03 10:42:09', N'1', N'2023-07-19 20:09:12', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (117, 11, N'鏀粯瀹?Wap 缃戠珯鏀粯', N'alipay_wap', N'pay_channel_code', 0, N'primary', N'', N'鏀粯瀹?Wap 缃戠珯鏀粯', N'1', N'2021-12-03 10:42:26', N'1', N'2023-07-19 20:09:16', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (118, 12, N'鏀粯瀹?App 鏀粯', N'alipay_app', N'pay_channel_code', 0, N'primary', N'', N'鏀粯瀹?App 鏀粯', N'1', N'2021-12-03 10:42:55', N'1', N'2023-07-19 20:09:20', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (119, 14, N'鏀粯瀹濇壂鐮佹敮浠?, N'alipay_qr', N'pay_channel_code', 0, N'primary', N'', N'鏀粯瀹濇壂鐮佹敮浠?, N'1', N'2021-12-03 10:43:10', N'1', N'2023-07-19 20:09:28', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (120, 10, N'閫氱煡鎴愬姛', N'10', N'pay_notify_status', 0, N'success', N'', N'閫氱煡鎴愬姛', N'1', N'2021-12-03 11:02:41', N'1', N'2023-07-19 10:08:19', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (121, 20, N'閫氱煡澶辫触', N'20', N'pay_notify_status', 0, N'danger', N'', N'閫氱煡澶辫触', N'1', N'2021-12-03 11:02:59', N'1', N'2023-07-19 10:08:21', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (122, 0, N'绛夊緟閫氱煡', N'0', N'pay_notify_status', 0, N'info', N'', N'鏈€氱煡', N'1', N'2021-12-03 11:03:10', N'1', N'2023-07-19 10:08:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (123, 10, N'鏀粯鎴愬姛', N'10', N'pay_order_status', 0, N'success', N'', N'鏀粯鎴愬姛', N'1', N'2021-12-03 11:18:29', N'1', N'2023-07-19 18:04:28', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (124, 30, N'鏀粯鍏抽棴', N'30', N'pay_order_status', 0, N'info', N'', N'鏀粯鍏抽棴', N'1', N'2021-12-03 11:18:42', N'1', N'2023-07-19 18:05:07', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (125, 0, N'绛夊緟鏀粯', N'0', N'pay_order_status', 0, N'info', N'', N'鏈敮浠?, N'1', N'2021-12-03 11:18:18', N'1', N'2023-07-19 18:04:15', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (600, 5, N'棣栭〉', N'1', N'promotion_banner_position', 0, N'warning', N'', N'', N'1', N'2023-10-11 07:45:24', N'1', N'2023-10-11 07:45:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (601, 4, N'绉掓潃娲诲姩椤?, N'2', N'promotion_banner_position', 0, N'warning', N'', N'', N'1', N'2023-10-11 07:45:24', N'1', N'2023-10-11 07:45:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (602, 3, N'鐮嶄环娲诲姩椤?, N'3', N'promotion_banner_position', 0, N'warning', N'', N'', N'1', N'2023-10-11 07:45:24', N'1', N'2023-10-11 07:45:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (603, 2, N'闄愭椂鎶樻墸椤?, N'4', N'promotion_banner_position', 0, N'warning', N'', N'', N'1', N'2023-10-11 07:45:24', N'1', N'2023-10-11 07:45:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (604, 1, N'婊″噺閫侀〉', N'5', N'promotion_banner_position', 0, N'warning', N'', N'', N'1', N'2023-10-11 07:45:24', N'1', N'2023-10-11 07:45:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1118, 0, N'绛夊緟閫€娆?, N'0', N'pay_refund_status', 0, N'info', N'', N'绛夊緟閫€娆?, N'1', N'2021-12-10 16:44:59', N'1', N'2023-07-19 10:14:39', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1119, 20, N'閫€娆惧け璐?, N'20', N'pay_refund_status', 0, N'danger', N'', N'閫€娆惧け璐?, N'1', N'2021-12-10 16:45:10', N'1', N'2023-07-19 10:15:10', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1124, 10, N'閫€娆炬垚鍔?, N'10', N'pay_refund_status', 0, N'success', N'', N'閫€娆炬垚鍔?, N'1', N'2021-12-10 16:46:26', N'1', N'2023-07-19 10:15:00', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1127, 1, N'瀹℃壒涓?, N'1', N'bpm_process_instance_status', 0, N'default', N'', N'娴佺▼瀹炰緥鐨勭姸鎬?- 杩涜涓?, N'1', N'2022-01-07 23:47:22', N'1', N'2024-03-16 16:11:45', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1128, 2, N'瀹℃壒閫氳繃', N'2', N'bpm_process_instance_status', 0, N'success', N'', N'娴佺▼瀹炰緥鐨勭姸鎬?- 宸插畬鎴?, N'1', N'2022-01-07 23:47:49', N'1', N'2024-03-16 16:11:54', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1129, 1, N'瀹℃壒涓?, N'1', N'bpm_task_status', 0, N'primary', N'', N'娴佺▼瀹炰緥鐨勭粨鏋?- 澶勭悊涓?, N'1', N'2022-01-07 23:48:32', N'1', N'2024-03-08 22:41:37', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1130, 2, N'瀹℃壒閫氳繃', N'2', N'bpm_task_status', 0, N'success', N'', N'娴佺▼瀹炰緥鐨勭粨鏋?- 閫氳繃', N'1', N'2022-01-07 23:48:45', N'1', N'2024-03-08 22:41:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1131, 3, N'瀹℃壒涓嶉€氳繃', N'3', N'bpm_task_status', 0, N'danger', N'', N'娴佺▼瀹炰緥鐨勭粨鏋?- 涓嶉€氳繃', N'1', N'2022-01-07 23:48:55', N'1', N'2024-03-08 22:41:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1132, 4, N'宸插彇娑?, N'4', N'bpm_task_status', 0, N'info', N'', N'娴佺▼瀹炰緥鐨勭粨鏋?- 鎾ら攢', N'1', N'2022-01-07 23:49:06', N'1', N'2024-03-08 22:41:39', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1133, 10, N'娴佺▼琛ㄥ崟', N'10', N'bpm_model_form_type', 0, N'', N'', N'娴佺▼鐨勮〃鍗曠被鍨?- 娴佺▼琛ㄥ崟', N'103', N'2022-01-11 23:51:30', N'103', N'2022-01-11 23:51:30', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1134, 20, N'涓氬姟琛ㄥ崟', N'20', N'bpm_model_form_type', 0, N'', N'', N'娴佺▼鐨勮〃鍗曠被鍨?- 涓氬姟琛ㄥ崟', N'103', N'2022-01-11 23:51:47', N'103', N'2022-01-11 23:51:47', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1135, 10, N'瑙掕壊', N'10', N'bpm_task_candidate_strategy', 0, N'info', N'', N'浠诲姟鍒嗛厤瑙勫垯鐨勭被鍨?- 瑙掕壊', N'103', N'2022-01-12 23:21:22', N'1', N'2024-03-06 02:53:16', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1136, 20, N'閮ㄩ棬鐨勬垚鍛?, N'20', N'bpm_task_candidate_strategy', 0, N'primary', N'', N'浠诲姟鍒嗛厤瑙勫垯鐨勭被鍨?- 閮ㄩ棬鐨勬垚鍛?, N'103', N'2022-01-12 23:21:47', N'1', N'2024-03-06 02:53:17', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1137, 21, N'閮ㄩ棬鐨勮礋璐ｄ汉', N'21', N'bpm_task_candidate_strategy', 0, N'primary', N'', N'浠诲姟鍒嗛厤瑙勫垯鐨勭被鍨?- 閮ㄩ棬鐨勮礋璐ｄ汉', N'103', N'2022-01-12 23:33:36', N'1', N'2024-03-06 02:53:18', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1138, 30, N'鐢ㄦ埛', N'30', N'bpm_task_candidate_strategy', 0, N'info', N'', N'浠诲姟鍒嗛厤瑙勫垯鐨勭被鍨?- 鐢ㄦ埛', N'103', N'2022-01-12 23:34:02', N'1', N'2024-03-06 02:53:19', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1139, 40, N'鐢ㄦ埛缁?, N'40', N'bpm_task_candidate_strategy', 0, N'warning', N'', N'浠诲姟鍒嗛厤瑙勫垯鐨勭被鍨?- 鐢ㄦ埛缁?, N'103', N'2022-01-12 23:34:21', N'1', N'2024-03-06 02:53:20', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1140, 60, N'娴佺▼琛ㄨ揪寮?, N'60', N'bpm_task_candidate_strategy', 0, N'danger', N'', N'浠诲姟鍒嗛厤瑙勫垯鐨勭被鍨?- 娴佺▼琛ㄨ揪寮?, N'103', N'2022-01-12 23:34:43', N'1', N'2024-03-06 02:53:20', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1141, 22, N'宀椾綅', N'22', N'bpm_task_candidate_strategy', 0, N'success', N'', N'浠诲姟鍒嗛厤瑙勫垯鐨勭被鍨?- 宀椾綅', N'103', N'2022-01-14 18:41:55', N'1', N'2024-03-06 02:53:21', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1145, 1, N'绠＄悊鍚庡彴', N'1', N'infra_codegen_scene', 0, N'', N'', N'浠ｇ爜鐢熸垚鐨勫満鏅灇涓?- 绠＄悊鍚庡彴', N'1', N'2022-02-02 13:15:06', N'1', N'2022-03-10 16:32:59', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1146, 2, N'鐢ㄦ埛 APP', N'2', N'infra_codegen_scene', 0, N'', N'', N'浠ｇ爜鐢熸垚鐨勫満鏅灇涓?- 鐢ㄦ埛 APP', N'1', N'2022-02-02 13:15:19', N'1', N'2022-03-10 16:33:03', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1150, 1, N'鏁版嵁搴?, N'1', N'infra_file_storage', 0, N'default', N'', NULL, N'1', N'2022-03-15 00:25:28', N'1', N'2022-03-15 00:25:28', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1151, 10, N'鏈湴纾佺洏', N'10', N'infra_file_storage', 0, N'default', N'', NULL, N'1', N'2022-03-15 00:25:41', N'1', N'2022-03-15 00:25:56', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1152, 11, N'FTP 鏈嶅姟鍣?, N'11', N'infra_file_storage', 0, N'default', N'', NULL, N'1', N'2022-03-15 00:26:06', N'1', N'2022-03-15 00:26:10', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1153, 12, N'SFTP 鏈嶅姟鍣?, N'12', N'infra_file_storage', 0, N'default', N'', NULL, N'1', N'2022-03-15 00:26:22', N'1', N'2022-03-15 00:26:22', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1154, 20, N'S3 瀵硅薄瀛樺偍', N'20', N'infra_file_storage', 0, N'default', N'', NULL, N'1', N'2022-03-15 00:26:31', N'1', N'2022-03-15 00:26:45', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1155, 103, N'鐭俊鐧诲綍', N'103', N'system_login_type', 0, N'default', N'', NULL, N'1', N'2022-05-09 23:57:58', N'1', N'2022-05-09 23:58:09', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1156, 1, N'password', N'password', N'system_oauth2_grant_type', 0, N'default', N'', N'瀵嗙爜妯″紡', N'1', N'2022-05-12 00:22:05', N'1', N'2022-05-11 16:26:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1157, 2, N'authorization_code', N'authorization_code', N'system_oauth2_grant_type', 0, N'primary', N'', N'鎺堟潈鐮佹ā寮?, N'1', N'2022-05-12 00:22:59', N'1', N'2022-05-11 16:26:02', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1158, 3, N'implicit', N'implicit', N'system_oauth2_grant_type', 0, N'success', N'', N'绠€鍖栨ā寮?, N'1', N'2022-05-12 00:23:40', N'1', N'2022-05-11 16:26:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1159, 4, N'client_credentials', N'client_credentials', N'system_oauth2_grant_type', 0, N'default', N'', N'瀹㈡埛绔ā寮?, N'1', N'2022-05-12 00:23:51', N'1', N'2022-05-11 16:26:08', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1160, 5, N'refresh_token', N'refresh_token', N'system_oauth2_grant_type', 0, N'info', N'', N'鍒锋柊妯″紡', N'1', N'2022-05-12 00:24:02', N'1', N'2022-05-11 16:26:11', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1162, 1, N'閿€鍞腑', N'1', N'product_spu_status', 0, N'success', N'', N'鍟嗗搧 SPU 鐘舵€?- 閿€鍞腑', N'1', N'2022-10-24 21:19:47', N'1', N'2022-10-24 21:20:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1163, 0, N'浠撳簱涓?, N'0', N'product_spu_status', 0, N'info', N'', N'鍟嗗搧 SPU 鐘舵€?- 浠撳簱涓?, N'1', N'2022-10-24 21:20:54', N'1', N'2022-10-24 21:21:22', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1164, 0, N'鍥炴敹绔?, N'-1', N'product_spu_status', 0, N'default', N'', N'鍟嗗搧 SPU 鐘舵€?- 鍥炴敹绔?, N'1', N'2022-10-24 21:21:11', N'1', N'2022-10-24 21:21:11', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1165, 1, N'婊″噺', N'1', N'promotion_discount_type', 0, N'success', N'', N'浼樻儬绫诲瀷 - 婊″噺', N'1', N'2022-11-01 12:46:41', N'1', N'2022-11-01 12:50:11', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1166, 2, N'鎶樻墸', N'2', N'promotion_discount_type', 0, N'primary', N'', N'浼樻儬绫诲瀷 - 鎶樻墸', N'1', N'2022-11-01 12:46:51', N'1', N'2022-11-01 12:50:08', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1167, 1, N'鍥哄畾鏃ユ湡', N'1', N'promotion_coupon_template_validity_type', 0, N'default', N'', N'浼樻儬鍔垫ā鏉跨殑鏈夐檺鏈熺被鍨?- 鍥哄畾鏃ユ湡', N'1', N'2022-11-02 00:07:34', N'1', N'2022-11-04 00:07:49', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1168, 2, N'棰嗗彇涔嬪悗', N'2', N'promotion_coupon_template_validity_type', 0, N'default', N'', N'浼樻儬鍔垫ā鏉跨殑鏈夐檺鏈熺被鍨?- 棰嗗彇涔嬪悗', N'1', N'2022-11-02 00:07:54', N'1', N'2022-11-04 00:07:52', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1169, 1, N'閫氱敤鍔?, N'1', N'promotion_product_scope', 0, N'default', N'', N'钀ラ攢鐨勫晢鍝佽寖鍥?- 鍏ㄩ儴鍟嗗搧鍙備笌', N'1', N'2022-11-02 00:28:22', N'1', N'2023-09-28 00:27:42', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1170, 2, N'鍟嗗搧鍔?, N'2', N'promotion_product_scope', 0, N'default', N'', N'钀ラ攢鐨勫晢鍝佽寖鍥?- 鎸囧畾鍟嗗搧鍙備笌', N'1', N'2022-11-02 00:28:34', N'1', N'2023-09-28 00:27:44', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1171, 1, N'鏈娇鐢?, N'1', N'promotion_coupon_status', 0, N'primary', N'', N'浼樻儬鍔电殑鐘舵€?- 宸查鍙?, N'1', N'2022-11-04 00:15:08', N'1', N'2023-10-03 12:54:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1172, 2, N'宸蹭娇鐢?, N'2', N'promotion_coupon_status', 0, N'success', N'', N'浼樻儬鍔电殑鐘舵€?- 宸蹭娇鐢?, N'1', N'2022-11-04 00:15:21', N'1', N'2022-11-04 19:16:08', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1173, 3, N'宸茶繃鏈?, N'3', N'promotion_coupon_status', 0, N'info', N'', N'浼樻儬鍔电殑鐘舵€?- 宸茶繃鏈?, N'1', N'2022-11-04 00:15:43', N'1', N'2022-11-04 19:16:12', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1174, 1, N'鐩存帴棰嗗彇', N'1', N'promotion_coupon_take_type', 0, N'primary', N'', N'浼樻儬鍔电殑棰嗗彇鏂瑰紡 - 鐩存帴棰嗗彇', N'1', N'2022-11-04 19:13:00', N'1', N'2022-11-04 19:13:25', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1175, 2, N'鎸囧畾鍙戞斁', N'2', N'promotion_coupon_take_type', 0, N'success', N'', N'浼樻儬鍔电殑棰嗗彇鏂瑰紡 - 鎸囧畾鍙戞斁', N'1', N'2022-11-04 19:13:13', N'1', N'2022-11-04 19:14:48', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1176, 10, N'鏈紑濮?, N'10', N'promotion_activity_status', 0, N'primary', N'', N'淇冮攢娲诲姩鐨勭姸鎬佹灇涓?- 鏈紑濮?, N'1', N'2022-11-04 22:54:49', N'1', N'2022-11-04 22:55:53', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1177, 20, N'杩涜涓?, N'20', N'promotion_activity_status', 0, N'success', N'', N'淇冮攢娲诲姩鐨勭姸鎬佹灇涓?- 杩涜涓?, N'1', N'2022-11-04 22:55:06', N'1', N'2022-11-04 22:55:20', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1178, 30, N'宸茬粨鏉?, N'30', N'promotion_activity_status', 0, N'info', N'', N'淇冮攢娲诲姩鐨勭姸鎬佹灇涓?- 宸茬粨鏉?, N'1', N'2022-11-04 22:55:41', N'1', N'2022-11-04 22:55:41', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1179, 40, N'宸插叧闂?, N'40', N'promotion_activity_status', 0, N'warning', N'', N'淇冮攢娲诲姩鐨勭姸鎬佹灇涓?- 宸插叧闂?, N'1', N'2022-11-04 22:56:10', N'1', N'2022-11-04 22:56:18', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1180, 10, N'婊?N 鍏?, N'10', N'promotion_condition_type', 0, N'primary', N'', N'钀ラ攢鐨勬潯浠剁被鍨?- 婊?N 鍏?, N'1', N'2022-11-04 22:59:45', N'1', N'2022-11-04 22:59:45', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1181, 20, N'婊?N 浠?, N'20', N'promotion_condition_type', 0, N'success', N'', N'钀ラ攢鐨勬潯浠剁被鍨?- 婊?N 浠?, N'1', N'2022-11-04 23:00:02', N'1', N'2022-11-04 23:00:02', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1182, 10, N'鐢宠鍞悗', N'10', N'trade_after_sale_status', 0, N'primary', N'', N'浜ゆ槗鍞悗鐘舵€?- 鐢宠鍞悗', N'1', N'2022-11-19 20:53:33', N'1', N'2022-11-19 20:54:42', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1183, 20, N'鍟嗗搧寰呴€€璐?, N'20', N'trade_after_sale_status', 0, N'primary', N'', N'浜ゆ槗鍞悗鐘舵€?- 鍟嗗搧寰呴€€璐?, N'1', N'2022-11-19 20:54:36', N'1', N'2022-11-19 20:58:58', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1184, 30, N'鍟嗗寰呮敹璐?, N'30', N'trade_after_sale_status', 0, N'primary', N'', N'浜ゆ槗鍞悗鐘舵€?- 鍟嗗寰呮敹璐?, N'1', N'2022-11-19 20:56:56', N'1', N'2022-11-19 20:59:20', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1185, 40, N'绛夊緟閫€娆?, N'40', N'trade_after_sale_status', 0, N'primary', N'', N'浜ゆ槗鍞悗鐘舵€?- 绛夊緟閫€娆?, N'1', N'2022-11-19 20:59:54', N'1', N'2022-11-19 21:00:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1186, 50, N'閫€娆炬垚鍔?, N'50', N'trade_after_sale_status', 0, N'default', N'', N'浜ゆ槗鍞悗鐘舵€?- 閫€娆炬垚鍔?, N'1', N'2022-11-19 21:00:33', N'1', N'2022-11-19 21:00:33', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1187, 61, N'涔板鍙栨秷', N'61', N'trade_after_sale_status', 0, N'info', N'', N'浜ゆ槗鍞悗鐘舵€?- 涔板鍙栨秷', N'1', N'2022-11-19 21:01:29', N'1', N'2022-11-19 21:01:29', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1188, 62, N'鍟嗗鎷掔粷', N'62', N'trade_after_sale_status', 0, N'info', N'', N'浜ゆ槗鍞悗鐘舵€?- 鍟嗗鎷掔粷', N'1', N'2022-11-19 21:02:17', N'1', N'2022-11-19 21:02:17', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1189, 63, N'鍟嗗鎷掓敹璐?, N'63', N'trade_after_sale_status', 0, N'info', N'', N'浜ゆ槗鍞悗鐘舵€?- 鍟嗗鎷掓敹璐?, N'1', N'2022-11-19 21:02:37', N'1', N'2022-11-19 21:03:07', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1190, 10, N'鍞腑閫€娆?, N'10', N'trade_after_sale_type', 0, N'success', N'', N'浜ゆ槗鍞悗鐨勭被鍨?- 鍞腑閫€娆?, N'1', N'2022-11-19 21:05:05', N'1', N'2022-11-19 21:38:23', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1191, 20, N'鍞悗閫€娆?, N'20', N'trade_after_sale_type', 0, N'primary', N'', N'浜ゆ槗鍞悗鐨勭被鍨?- 鍞悗閫€娆?, N'1', N'2022-11-19 21:05:32', N'1', N'2022-11-19 21:38:32', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1192, 10, N'浠呴€€娆?, N'10', N'trade_after_sale_way', 0, N'primary', N'', N'浜ゆ槗鍞悗鐨勬柟寮?- 浠呴€€娆?, N'1', N'2022-11-19 21:39:19', N'1', N'2022-11-19 21:39:19', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1193, 20, N'閫€璐ч€€娆?, N'20', N'trade_after_sale_way', 0, N'success', N'', N'浜ゆ槗鍞悗鐨勬柟寮?- 閫€璐ч€€娆?, N'1', N'2022-11-19 21:39:38', N'1', N'2022-11-19 21:39:49', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1194, 10, N'寰俊灏忕▼搴?, N'10', N'terminal', 0, N'default', N'', N'缁堢 - 寰俊灏忕▼搴?, N'1', N'2022-12-10 10:51:11', N'1', N'2022-12-10 10:51:57', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1195, 20, N'H5 缃戦〉', N'20', N'terminal', 0, N'default', N'', N'缁堢 - H5 缃戦〉', N'1', N'2022-12-10 10:51:30', N'1', N'2022-12-10 10:51:59', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1196, 11, N'寰俊鍏紬鍙?, N'11', N'terminal', 0, N'default', N'', N'缁堢 - 寰俊鍏紬鍙?, N'1', N'2022-12-10 10:54:16', N'1', N'2022-12-10 10:52:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1197, 31, N'鑻规灉 App', N'31', N'terminal', 0, N'default', N'', N'缁堢 - 鑻规灉 App', N'1', N'2022-12-10 10:54:42', N'1', N'2022-12-10 10:52:18', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1198, 32, N'瀹夊崜 App', N'32', N'terminal', 0, N'default', N'', N'缁堢 - 瀹夊崜 App', N'1', N'2022-12-10 10:55:02', N'1', N'2022-12-10 10:59:17', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1199, 0, N'鏅€氳鍗?, N'0', N'trade_order_type', 0, N'default', N'', N'浜ゆ槗璁㈠崟鐨勭被鍨?- 鏅€氳鍗?, N'1', N'2022-12-10 16:34:14', N'1', N'2022-12-10 16:34:14', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1200, 1, N'绉掓潃璁㈠崟', N'1', N'trade_order_type', 0, N'default', N'', N'浜ゆ槗璁㈠崟鐨勭被鍨?- 绉掓潃璁㈠崟', N'1', N'2022-12-10 16:34:26', N'1', N'2022-12-10 16:34:26', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1201, 2, N'鐮嶄环璁㈠崟', N'2', N'trade_order_type', 0, N'default', N'', N'浜ゆ槗璁㈠崟鐨勭被鍨?- 鎷煎洟璁㈠崟', N'1', N'2022-12-10 16:34:36', N'1', N'2024-09-07 14:18:39', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1202, 3, N'鎷煎洟璁㈠崟', N'3', N'trade_order_type', 0, N'default', N'', N'浜ゆ槗璁㈠崟鐨勭被鍨?- 鐮嶄环璁㈠崟', N'1', N'2022-12-10 16:34:48', N'1', N'2024-09-07 14:18:32', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1203, 0, N'寰呮敮浠?, N'0', N'trade_order_status', 0, N'default', N'', N'浜ゆ槗璁㈠崟鐘舵€?- 寰呮敮浠?, N'1', N'2022-12-10 16:49:29', N'1', N'2022-12-10 16:49:29', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1204, 10, N'寰呭彂璐?, N'10', N'trade_order_status', 0, N'primary', N'', N'浜ゆ槗璁㈠崟鐘舵€?- 寰呭彂璐?, N'1', N'2022-12-10 16:49:53', N'1', N'2022-12-10 16:51:17', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1205, 20, N'宸插彂璐?, N'20', N'trade_order_status', 0, N'primary', N'', N'浜ゆ槗璁㈠崟鐘舵€?- 宸插彂璐?, N'1', N'2022-12-10 16:50:13', N'1', N'2022-12-10 16:51:31', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1206, 30, N'宸插畬鎴?, N'30', N'trade_order_status', 0, N'success', N'', N'浜ゆ槗璁㈠崟鐘舵€?- 宸插畬鎴?, N'1', N'2022-12-10 16:50:30', N'1', N'2022-12-10 16:51:06', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1207, 40, N'宸插彇娑?, N'40', N'trade_order_status', 0, N'danger', N'', N'浜ゆ槗璁㈠崟鐘舵€?- 宸插彇娑?, N'1', N'2022-12-10 16:50:50', N'1', N'2022-12-10 16:51:00', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1208, 0, N'鏈敭鍚?, N'0', N'trade_order_item_after_sale_status', 0, N'info', N'', N'浜ゆ槗璁㈠崟椤圭殑鍞悗鐘舵€?- 鏈敭鍚?, N'1', N'2022-12-10 20:58:42', N'1', N'2022-12-10 20:59:29', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1209, 10, N'鍞悗涓?, N'10', N'trade_order_item_after_sale_status', 0, N'primary', N'', N'浜ゆ槗璁㈠崟椤圭殑鍞悗鐘舵€?- 鍞悗涓?, N'1', N'2022-12-10 20:59:21', N'1', N'2024-07-21 17:01:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1210, 20, N'宸查€€娆?, N'20', N'trade_order_item_after_sale_status', 0, N'success', N'', N'浜ゆ槗璁㈠崟椤圭殑鍞悗鐘舵€?- 宸查€€娆?, N'1', N'2022-12-10 20:59:46', N'1', N'2024-07-21 17:01:35', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1211, 1, N'瀹屽叏鍖归厤', N'1', N'mp_auto_reply_request_match', 0, N'primary', N'', N'鍏紬鍙疯嚜鍔ㄥ洖澶嶇殑璇锋眰鍏抽敭瀛楀尮閰嶆ā寮?- 瀹屽叏鍖归厤', N'1', N'2023-01-16 23:30:39', N'1', N'2023-01-16 23:31:00', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1212, 2, N'鍗婂尮閰?, N'2', N'mp_auto_reply_request_match', 0, N'success', N'', N'鍏紬鍙疯嚜鍔ㄥ洖澶嶇殑璇锋眰鍏抽敭瀛楀尮閰嶆ā寮?- 鍗婂尮閰?, N'1', N'2023-01-16 23:30:55', N'1', N'2023-01-16 23:31:10', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1213, 1, N'鏂囨湰', N'text', N'mp_message_type', 0, N'default', N'', N'鍏紬鍙风殑娑堟伅绫诲瀷 - 鏂囨湰', N'1', N'2023-01-17 22:17:32', N'1', N'2023-01-17 22:17:39', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1214, 2, N'鍥剧墖', N'image', N'mp_message_type', 0, N'default', N'', N'鍏紬鍙风殑娑堟伅绫诲瀷 - 鍥剧墖', N'1', N'2023-01-17 22:17:32', N'1', N'2023-01-17 14:19:47', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1215, 3, N'璇煶', N'voice', N'mp_message_type', 0, N'default', N'', N'鍏紬鍙风殑娑堟伅绫诲瀷 - 璇煶', N'1', N'2023-01-17 22:17:32', N'1', N'2023-01-17 14:20:08', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1216, 4, N'瑙嗛', N'video', N'mp_message_type', 0, N'default', N'', N'鍏紬鍙风殑娑堟伅绫诲瀷 - 瑙嗛', N'1', N'2023-01-17 22:17:32', N'1', N'2023-01-17 14:21:08', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1217, 5, N'灏忚棰?, N'shortvideo', N'mp_message_type', 0, N'default', N'', N'鍏紬鍙风殑娑堟伅绫诲瀷 - 灏忚棰?, N'1', N'2023-01-17 22:17:32', N'1', N'2023-01-17 14:19:59', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1218, 6, N'鍥炬枃', N'news', N'mp_message_type', 0, N'default', N'', N'鍏紬鍙风殑娑堟伅绫诲瀷 - 鍥炬枃', N'1', N'2023-01-17 22:17:32', N'1', N'2023-01-17 14:22:54', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1219, 7, N'闊充箰', N'music', N'mp_message_type', 0, N'default', N'', N'鍏紬鍙风殑娑堟伅绫诲瀷 - 闊充箰', N'1', N'2023-01-17 22:17:32', N'1', N'2023-01-17 14:22:54', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1220, 8, N'鍦扮悊浣嶇疆', N'location', N'mp_message_type', 0, N'default', N'', N'鍏紬鍙风殑娑堟伅绫诲瀷 - 鍦扮悊浣嶇疆', N'1', N'2023-01-17 22:17:32', N'1', N'2023-01-17 14:23:51', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1221, 9, N'閾炬帴', N'link', N'mp_message_type', 0, N'default', N'', N'鍏紬鍙风殑娑堟伅绫诲瀷 - 閾炬帴', N'1', N'2023-01-17 22:17:32', N'1', N'2023-01-17 14:24:49', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1222, 10, N'浜嬩欢', N'event', N'mp_message_type', 0, N'default', N'', N'鍏紬鍙风殑娑堟伅绫诲瀷 - 浜嬩欢', N'1', N'2023-01-17 22:17:32', N'1', N'2023-01-17 14:24:49', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1223, 0, N'鍒濆鍖?, N'0', N'system_mail_send_status', 0, N'primary', N'', N'閭欢鍙戦€佺姸鎬?- 鍒濆鍖朶n', N'1', N'2023-01-26 09:53:49', N'1', N'2023-01-26 16:36:14', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1224, 10, N'鍙戦€佹垚鍔?, N'10', N'system_mail_send_status', 0, N'success', N'', N'閭欢鍙戦€佺姸鎬?- 鍙戦€佹垚鍔?, N'1', N'2023-01-26 09:54:28', N'1', N'2023-01-26 16:36:22', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1225, 20, N'鍙戦€佸け璐?, N'20', N'system_mail_send_status', 0, N'danger', N'', N'閭欢鍙戦€佺姸鎬?- 鍙戦€佸け璐?, N'1', N'2023-01-26 09:54:50', N'1', N'2023-01-26 16:36:26', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1226, 30, N'涓嶅彂閫?, N'30', N'system_mail_send_status', 0, N'info', N'', N'閭欢鍙戦€佺姸鎬?-  涓嶅彂閫?, N'1', N'2023-01-26 09:55:06', N'1', N'2023-01-26 16:36:36', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1227, 1, N'閫氱煡鍏憡', N'1', N'system_notify_template_type', 0, N'primary', N'', N'绔欏唴淇℃ā鐗堢殑绫诲瀷 - 閫氱煡鍏憡', N'1', N'2023-01-28 10:35:59', N'1', N'2023-01-28 10:35:59', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1228, 2, N'绯荤粺娑堟伅', N'2', N'system_notify_template_type', 0, N'success', N'', N'绔欏唴淇℃ā鐗堢殑绫诲瀷 - 绯荤粺娑堟伅', N'1', N'2023-01-28 10:36:20', N'1', N'2023-01-28 10:36:25', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1230, 13, N'鏀粯瀹濇潯鐮佹敮浠?, N'alipay_bar', N'pay_channel_code', 0, N'primary', N'', N'鏀粯瀹濇潯鐮佹敮浠?, N'1', N'2023-02-18 23:32:24', N'1', N'2023-07-19 20:09:23', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1231, 10, N'Vue2 Element UI 鏍囧噯妯＄増', N'10', N'infra_codegen_front_type', 0, N'', N'', N'', N'1', N'2023-04-13 00:03:55', N'1', N'2023-04-13 00:03:55', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1232, 20, N'Vue3 Element Plus 鏍囧噯妯＄増', N'20', N'infra_codegen_front_type', 0, N'', N'', N'', N'1', N'2023-04-13 00:04:08', N'1', N'2023-04-13 00:04:08', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1234, 30, N'Vben2.0 Ant Design Schema 妯＄増', N'30', N'infra_codegen_front_type', 0, N'', N'', N'', N'1', N'2023-04-13 00:04:26', N'1', N'2025-04-23 21:27:34', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1244, 0, N'鎸変欢', N'1', N'trade_delivery_express_charge_mode', 0, N'', N'', N'', N'1', N'2023-05-21 22:46:40', N'1', N'2023-05-21 22:46:40', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1245, 1, N'鎸夐噸閲?, N'2', N'trade_delivery_express_charge_mode', 0, N'', N'', N'', N'1', N'2023-05-21 22:46:58', N'1', N'2023-05-21 22:46:58', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1246, 2, N'鎸変綋绉?, N'3', N'trade_delivery_express_charge_mode', 0, N'', N'', N'', N'1', N'2023-05-21 22:47:18', N'1', N'2023-05-21 22:47:18', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1335, 11, N'璁㈠崟绉垎鎶垫墸', N'11', N'member_point_biz_type', 0, N'', N'', N'', N'1', N'2023-06-10 12:15:27', N'1', N'2023-10-11 07:41:43', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1336, 1, N'绛惧埌', N'1', N'member_point_biz_type', 0, N'', N'', N'', N'1', N'2023-06-10 12:15:48', N'1', N'2023-08-20 11:59:53', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1341, 20, N'宸查€€娆?, N'20', N'pay_order_status', 0, N'danger', N'', N'宸查€€娆?, N'1', N'2023-07-19 18:05:37', N'1', N'2023-07-19 18:05:37', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1342, 21, N'璇锋眰鎴愬姛锛屼絾鏄粨鏋滃け璐?, N'21', N'pay_notify_status', 0, N'warning', N'', N'璇锋眰鎴愬姛锛屼絾鏄粨鏋滃け璐?, N'1', N'2023-07-19 18:10:47', N'1', N'2023-07-19 18:11:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1343, 22, N'璇锋眰澶辫触', N'22', N'pay_notify_status', 0, N'warning', N'', NULL, N'1', N'2023-07-19 18:11:05', N'1', N'2023-07-19 18:11:27', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1344, 4, N'寰俊鎵爜鏀粯', N'wx_native', N'pay_channel_code', 0, N'success', N'', N'寰俊鎵爜鏀粯', N'1', N'2023-07-19 20:07:47', N'1', N'2023-07-19 20:09:03', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1345, 5, N'寰俊鏉＄爜鏀粯', N'wx_bar', N'pay_channel_code', 0, N'success', N'', N'寰俊鏉＄爜鏀粯\n', N'1', N'2023-07-19 20:08:06', N'1', N'2023-07-19 20:09:08', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1346, 1, N'鏀粯鍗?, N'1', N'pay_notify_type', 0, N'primary', N'', N'鏀粯鍗?, N'1', N'2023-07-20 12:23:17', N'1', N'2023-07-20 12:23:17', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1347, 2, N'閫€娆惧崟', N'2', N'pay_notify_type', 0, N'danger', N'', NULL, N'1', N'2023-07-20 12:23:26', N'1', N'2023-07-20 12:23:26', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1348, 20, N'妯℃嫙鏀粯', N'mock', N'pay_channel_code', 0, N'default', N'', N'妯℃嫙鏀粯', N'1', N'2023-07-29 11:10:51', N'1', N'2023-07-29 03:14:10', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1349, 12, N'璁㈠崟绉垎鎶垫墸锛堟暣鍗曞彇娑堬級', N'12', N'member_point_biz_type', 0, N'', N'', N'', N'1', N'2023-08-20 12:00:03', N'1', N'2023-10-11 07:42:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1350, 0, N'绠＄悊鍛樿皟鏁?, N'0', N'member_experience_biz_type', 0, N'', N'', NULL, N'', N'2023-08-22 12:41:01', N'', N'2023-08-22 12:41:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1351, 1, N'閭€鏂板鍔?, N'1', N'member_experience_biz_type', 0, N'', N'', NULL, N'', N'2023-08-22 12:41:01', N'', N'2023-08-22 12:41:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1352, 11, N'涓嬪崟濂栧姳', N'11', N'member_experience_biz_type', 0, N'success', N'', NULL, N'', N'2023-08-22 12:41:01', N'1', N'2023-10-11 07:45:09', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1353, 12, N'涓嬪崟濂栧姳锛堟暣鍗曞彇娑堬級', N'12', N'member_experience_biz_type', 0, N'warning', N'', NULL, N'', N'2023-08-22 12:41:01', N'1', N'2023-10-11 07:45:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1354, 4, N'绛惧埌濂栧姳', N'4', N'member_experience_biz_type', 0, N'', N'', NULL, N'', N'2023-08-22 12:41:01', N'', N'2023-08-22 12:41:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1355, 5, N'鎶藉濂栧姳', N'5', N'member_experience_biz_type', 0, N'', N'', NULL, N'', N'2023-08-22 12:41:01', N'', N'2023-08-22 12:41:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1356, 1, N'蹇€掑彂璐?, N'1', N'trade_delivery_type', 0, N'', N'', N'', N'1', N'2023-08-23 00:04:55', N'1', N'2023-08-23 00:04:55', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1357, 2, N'鐢ㄦ埛鑷彁', N'2', N'trade_delivery_type', 0, N'', N'', N'', N'1', N'2023-08-23 00:05:05', N'1', N'2023-08-23 00:05:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1358, 3, N'鍝佺被鍔?, N'3', N'promotion_product_scope', 0, N'default', N'', N'', N'1', N'2023-09-01 23:43:07', N'1', N'2023-09-28 00:27:47', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1359, 1, N'浜轰汉鍒嗛攢', N'1', N'brokerage_enabled_condition', 0, N'', N'', N'鎵€鏈夌敤鎴烽兘鍙互鍒嗛攢', N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1360, 2, N'鎸囧畾鍒嗛攢', N'2', N'brokerage_enabled_condition', 0, N'', N'', N'浠呭彲鍚庡彴鎵嬪姩璁剧疆鎺ㄥ箍鍛?, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1361, 1, N'棣栨缁戝畾', N'1', N'brokerage_bind_mode', 0, N'', N'', N'鍙鐢ㄦ埛娌℃湁鎺ㄥ箍浜猴紝闅忔椂閮藉彲浠ョ粦瀹氭帹骞垮叧绯?, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1362, 2, N'娉ㄥ唽缁戝畾', N'2', N'brokerage_bind_mode', 0, N'', N'', N'浠呮柊鐢ㄦ埛娉ㄥ唽鏃舵墠鑳界粦瀹氭帹骞垮叧绯?, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1363, 3, N'瑕嗙洊缁戝畾', N'3', N'brokerage_bind_mode', 0, N'', N'', N'濡傛灉鐢ㄦ埛宸茬粡鏈夋帹骞夸汉锛屾帹骞夸汉浼氳鍙樻洿', N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1364, 1, N'閽卞寘', N'1', N'brokerage_withdraw_type', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1365, 2, N'閾惰鍗?, N'2', N'brokerage_withdraw_type', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1366, 3, N'寰俊鏀舵鐮?, N'3', N'brokerage_withdraw_type', 0, N'', N'', N'鎵嬪姩鎵撴', N'', N'2023-09-28 02:46:05', N'1', N'2025-05-10 08:24:25', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1367, 4, N'鏀粯瀹濇敹娆剧爜', N'4', N'brokerage_withdraw_type', 0, N'', N'', N'鎵嬪姩鎵撴', N'', N'2023-09-28 02:46:05', N'1', N'2025-05-10 08:24:37', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1368, 1, N'璁㈠崟杩斾剑', N'1', N'brokerage_record_biz_type', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1369, 2, N'鐢宠鎻愮幇', N'2', N'brokerage_record_biz_type', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1370, 3, N'鐢宠鎻愮幇椹冲洖', N'3', N'brokerage_record_biz_type', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1371, 0, N'寰呯粨绠?, N'0', N'brokerage_record_status', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1372, 1, N'宸茬粨绠?, N'1', N'brokerage_record_status', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1373, 2, N'宸插彇娑?, N'2', N'brokerage_record_status', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1374, 0, N'瀹℃牳涓?, N'0', N'brokerage_withdraw_status', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1375, 10, N'瀹℃牳閫氳繃', N'10', N'brokerage_withdraw_status', 0, N'success', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1376, 11, N'鎻愮幇鎴愬姛', N'11', N'brokerage_withdraw_status', 0, N'success', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1377, 20, N'瀹℃牳涓嶉€氳繃', N'20', N'brokerage_withdraw_status', 0, N'danger', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1378, 21, N'鎻愮幇澶辫触', N'21', N'brokerage_withdraw_status', 0, N'danger', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1379, 0, N'宸ュ晢閾惰', N'0', N'brokerage_bank_name', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1380, 1, N'寤鸿閾惰', N'1', N'brokerage_bank_name', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1381, 2, N'鍐滀笟閾惰', N'2', N'brokerage_bank_name', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1382, 3, N'涓浗閾惰', N'3', N'brokerage_bank_name', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1383, 4, N'浜ら€氶摱琛?, N'4', N'brokerage_bank_name', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1384, 5, N'鎷涘晢閾惰', N'5', N'brokerage_bank_name', 0, N'', N'', NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1385, 21, N'閽卞寘', N'wallet', N'pay_channel_code', 0, N'primary', N'', N'', N'1', N'2023-10-01 21:46:19', N'1', N'2023-10-01 21:48:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1386, 1, N'鐮嶄环涓?, N'1', N'promotion_bargain_record_status', 0, N'default', N'', N'', N'1', N'2023-10-05 10:41:26', N'1', N'2023-10-05 10:41:26', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1387, 2, N'鐮嶄环鎴愬姛', N'2', N'promotion_bargain_record_status', 0, N'success', N'', N'', N'1', N'2023-10-05 10:41:39', N'1', N'2023-10-05 10:41:39', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1388, 3, N'鐮嶄环澶辫触', N'3', N'promotion_bargain_record_status', 0, N'warning', N'', N'', N'1', N'2023-10-05 10:41:57', N'1', N'2023-10-05 10:41:57', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1389, 0, N'鎷煎洟涓?, N'0', N'promotion_combination_record_status', 0, N'', N'', N'', N'1', N'2023-10-08 07:24:44', N'1', N'2024-10-13 10:08:17', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1390, 1, N'鎷煎洟鎴愬姛', N'1', N'promotion_combination_record_status', 0, N'success', N'', N'', N'1', N'2023-10-08 07:24:56', N'1', N'2024-10-13 10:08:20', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1391, 2, N'鎷煎洟澶辫触', N'2', N'promotion_combination_record_status', 0, N'warning', N'', N'', N'1', N'2023-10-08 07:25:11', N'1', N'2024-10-13 10:08:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1392, 2, N'绠＄悊鍛樹慨鏀?, N'2', N'member_point_biz_type', 0, N'default', N'', N'', N'1', N'2023-10-11 07:41:34', N'1', N'2023-10-11 07:41:34', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1393, 13, N'璁㈠崟绉垎鎶垫墸锛堝崟涓€€娆撅級', N'13', N'member_point_biz_type', 0, N'', N'', N'', N'1', N'2023-10-11 07:42:29', N'1', N'2023-10-11 07:42:29', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1394, 21, N'璁㈠崟绉垎濂栧姳', N'21', N'member_point_biz_type', 0, N'default', N'', N'', N'1', N'2023-10-11 07:42:44', N'1', N'2023-10-11 07:42:44', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1395, 22, N'璁㈠崟绉垎濂栧姳锛堟暣鍗曞彇娑堬級', N'22', N'member_point_biz_type', 0, N'default', N'', N'', N'1', N'2023-10-11 07:42:55', N'1', N'2023-10-11 07:43:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1396, 23, N'璁㈠崟绉垎濂栧姳锛堝崟涓€€娆撅級', N'23', N'member_point_biz_type', 0, N'default', N'', N'', N'1', N'2023-10-11 07:43:16', N'1', N'2023-10-11 07:43:16', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1397, 13, N'涓嬪崟濂栧姳锛堝崟涓€€娆撅級', N'13', N'member_experience_biz_type', 0, N'warning', N'', N'', N'1', N'2023-10-11 07:45:24', N'1', N'2023-10-11 07:45:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1398, 5, N'缃戜笂杞处', N'5', N'crm_receivable_return_type', 0, N'default', N'', N'', N'1', N'2023-10-18 21:55:24', N'1', N'2023-10-18 21:55:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1399, 6, N'鏀粯瀹?, N'6', N'crm_receivable_return_type', 0, N'default', N'', N'', N'1', N'2023-10-18 21:55:38', N'1', N'2023-10-18 21:55:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1400, 7, N'寰俊鏀粯', N'7', N'crm_receivable_return_type', 0, N'default', N'', N'', N'1', N'2023-10-18 21:55:53', N'1', N'2023-10-18 21:55:53', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1401, 8, N'鍏朵粬', N'8', N'crm_receivable_return_type', 0, N'default', N'', N'', N'1', N'2023-10-18 21:56:06', N'1', N'2023-10-18 21:56:06', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1402, 1, N'IT', N'1', N'crm_customer_industry', 0, N'default', N'', N'', N'1', N'2023-10-28 23:02:15', N'1', N'2024-02-18 23:30:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1403, 2, N'閲戣瀺涓?, N'2', N'crm_customer_industry', 0, N'default', N'', N'', N'1', N'2023-10-28 23:02:29', N'1', N'2024-02-18 23:30:43', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1404, 3, N'鎴垮湴浜?, N'3', N'crm_customer_industry', 0, N'default', N'', N'', N'1', N'2023-10-28 23:02:41', N'1', N'2024-02-18 23:30:48', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1405, 4, N'鍟嗕笟鏈嶅姟', N'4', N'crm_customer_industry', 0, N'default', N'', N'', N'1', N'2023-10-28 23:02:54', N'1', N'2024-02-18 23:30:54', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1406, 5, N'杩愯緭/鐗╂祦', N'5', N'crm_customer_industry', 0, N'default', N'', N'', N'1', N'2023-10-28 23:03:03', N'1', N'2024-02-18 23:31:00', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1407, 6, N'鐢熶骇', N'6', N'crm_customer_industry', 0, N'default', N'', N'', N'1', N'2023-10-28 23:03:13', N'1', N'2024-02-18 23:31:08', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1408, 7, N'鏀垮簻', N'7', N'crm_customer_industry', 0, N'default', N'', N'', N'1', N'2023-10-28 23:03:27', N'1', N'2024-02-18 23:31:13', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1409, 8, N'鏂囧寲浼犲獟', N'8', N'crm_customer_industry', 0, N'default', N'', N'', N'1', N'2023-10-28 23:03:37', N'1', N'2024-02-18 23:31:20', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1422, 1, N'A 锛堥噸鐐瑰鎴凤級', N'1', N'crm_customer_level', 0, N'primary', N'', N'', N'1', N'2023-10-28 23:07:13', N'1', N'2023-10-28 23:07:13', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1423, 2, N'B 锛堟櫘閫氬鎴凤級', N'2', N'crm_customer_level', 0, N'info', N'', N'', N'1', N'2023-10-28 23:07:35', N'1', N'2023-10-28 23:07:35', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1424, 3, N'C 锛堥潪浼樺厛瀹㈡埛锛?, N'3', N'crm_customer_level', 0, N'default', N'', N'', N'1', N'2023-10-28 23:07:53', N'1', N'2023-10-28 23:07:53', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1425, 1, N'淇冮攢', N'1', N'crm_customer_source', 0, N'default', N'', N'', N'1', N'2023-10-28 23:08:29', N'1', N'2023-10-28 23:08:29', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1426, 2, N'鎼滅储寮曟搸', N'2', N'crm_customer_source', 0, N'default', N'', N'', N'1', N'2023-10-28 23:08:39', N'1', N'2023-10-28 23:08:39', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1427, 3, N'骞垮憡', N'3', N'crm_customer_source', 0, N'default', N'', N'', N'1', N'2023-10-28 23:08:47', N'1', N'2023-10-28 23:08:47', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1428, 4, N'杞粙缁?, N'4', N'crm_customer_source', 0, N'default', N'', N'', N'1', N'2023-10-28 23:08:58', N'1', N'2023-10-28 23:08:58', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1429, 5, N'绾夸笂娉ㄥ唽', N'5', N'crm_customer_source', 0, N'default', N'', N'', N'1', N'2023-10-28 23:09:12', N'1', N'2023-10-28 23:09:12', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1430, 6, N'绾夸笂鍜ㄨ', N'6', N'crm_customer_source', 0, N'default', N'', N'', N'1', N'2023-10-28 23:09:22', N'1', N'2023-10-28 23:09:22', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1431, 7, N'棰勭害涓婇棬', N'7', N'crm_customer_source', 0, N'default', N'', N'', N'1', N'2023-10-28 23:09:39', N'1', N'2023-10-28 23:09:39', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1432, 8, N'闄屾嫓', N'8', N'crm_customer_source', 0, N'default', N'', N'', N'1', N'2023-10-28 23:10:04', N'1', N'2023-10-28 23:10:04', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1433, 9, N'鐢佃瘽鍜ㄨ', N'9', N'crm_customer_source', 0, N'default', N'', N'', N'1', N'2023-10-28 23:10:18', N'1', N'2023-10-28 23:10:18', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1434, 10, N'閭欢鍜ㄨ', N'10', N'crm_customer_source', 0, N'default', N'', N'', N'1', N'2023-10-28 23:10:33', N'1', N'2023-10-28 23:10:33', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1435, 10, N'Gitee', N'10', N'system_social_type', 0, N'', N'', N'', N'1', N'2023-11-04 13:04:42', N'1', N'2023-11-04 13:04:42', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1436, 20, N'閽夐拤', N'20', N'system_social_type', 0, N'', N'', N'', N'1', N'2023-11-04 13:04:54', N'1', N'2023-11-04 13:04:54', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1437, 30, N'浼佷笟寰俊', N'30', N'system_social_type', 0, N'', N'', N'', N'1', N'2023-11-04 13:05:09', N'1', N'2023-11-04 13:05:09', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1438, 31, N'寰俊鍏紬骞冲彴', N'31', N'system_social_type', 0, N'', N'', N'', N'1', N'2023-11-04 13:05:18', N'1', N'2023-11-04 13:05:18', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1439, 32, N'寰俊寮€鏀惧钩鍙?, N'32', N'system_social_type', 0, N'', N'', N'', N'1', N'2023-11-04 13:05:30', N'1', N'2023-11-04 13:05:30', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1440, 34, N'寰俊灏忕▼搴?, N'34', N'system_social_type', 0, N'', N'', N'', N'1', N'2023-11-04 13:05:38', N'1', N'2023-11-04 13:07:16', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1441, 1, N'涓婃灦', N'1', N'crm_product_status', 0, N'success', N'', N'', N'1', N'2023-10-30 21:49:34', N'1', N'2023-10-30 21:49:34', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1442, 0, N'涓嬫灦', N'0', N'crm_product_status', 0, N'success', N'', N'', N'1', N'2023-10-30 21:49:13', N'1', N'2023-10-30 21:49:13', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1443, 15, N'瀛愯〃', N'15', N'infra_codegen_template_type', 0, N'default', N'', N'', N'1', N'2023-11-13 23:06:16', N'1', N'2023-11-13 23:06:16', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1444, 10, N'涓昏〃锛堟爣鍑嗘ā寮忥級', N'10', N'infra_codegen_template_type', 0, N'default', N'', N'', N'1', N'2023-11-14 12:32:49', N'1', N'2023-11-14 12:32:49', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1445, 11, N'涓昏〃锛圗RP 妯″紡锛?, N'11', N'infra_codegen_template_type', 0, N'default', N'', N'', N'1', N'2023-11-14 12:33:05', N'1', N'2023-11-14 12:33:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1446, 12, N'涓昏〃锛堝唴宓屾ā寮忥級', N'12', N'infra_codegen_template_type', 0, N'', N'', N'', N'1', N'2023-11-14 12:33:31', N'1', N'2023-11-14 12:33:31', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1447, 1, N'璐熻矗浜?, N'1', N'crm_permission_level', 0, N'default', N'', N'', N'1', N'2023-11-30 09:53:12', N'1', N'2023-11-30 09:53:12', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1448, 2, N'鍙', N'2', N'crm_permission_level', 0, N'', N'', N'', N'1', N'2023-11-30 09:53:29', N'1', N'2023-11-30 09:53:29', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1449, 3, N'璇诲啓', N'3', N'crm_permission_level', 0, N'', N'', N'', N'1', N'2023-11-30 09:53:36', N'1', N'2023-11-30 09:53:36', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1450, 0, N'鏈彁浜?, N'0', N'crm_audit_status', 0, N'', N'', N'', N'1', N'2023-11-30 18:56:59', N'1', N'2023-11-30 18:56:59', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1451, 10, N'瀹℃壒涓?, N'10', N'crm_audit_status', 0, N'', N'', N'', N'1', N'2023-11-30 18:57:10', N'1', N'2023-11-30 18:57:10', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1452, 20, N'瀹℃牳閫氳繃', N'20', N'crm_audit_status', 0, N'', N'', N'', N'1', N'2023-11-30 18:57:24', N'1', N'2023-11-30 18:57:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1453, 30, N'瀹℃牳涓嶉€氳繃', N'30', N'crm_audit_status', 0, N'', N'', N'', N'1', N'2023-11-30 18:57:32', N'1', N'2023-11-30 18:57:32', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1454, 40, N'宸插彇娑?, N'40', N'crm_audit_status', 0, N'', N'', N'', N'1', N'2023-11-30 18:57:42', N'1', N'2023-11-30 18:57:42', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1456, 1, N'鏀エ', N'1', N'crm_receivable_return_type', 0, N'default', N'', N'', N'1', N'2023-10-18 21:54:29', N'1', N'2023-10-18 21:54:29', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1457, 2, N'鐜伴噾', N'2', N'crm_receivable_return_type', 0, N'default', N'', N'', N'1', N'2023-10-18 21:54:41', N'1', N'2023-10-18 21:54:41', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1458, 3, N'閭斂姹囨', N'3', N'crm_receivable_return_type', 0, N'default', N'', N'', N'1', N'2023-10-18 21:54:53', N'1', N'2023-10-18 21:54:53', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1459, 4, N'鐢垫眹', N'4', N'crm_receivable_return_type', 0, N'default', N'', N'', N'1', N'2023-10-18 21:55:07', N'1', N'2023-10-18 21:55:07', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1461, 1, N'涓?, N'1', N'crm_product_unit', 0, N'', N'', N'', N'1', N'2023-12-05 23:02:26', N'1', N'2023-12-05 23:02:26', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1462, 2, N'鍧?, N'2', N'crm_product_unit', 0, N'', N'', N'', N'1', N'2023-12-05 23:02:34', N'1', N'2023-12-05 23:02:34', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1463, 3, N'鍙?, N'3', N'crm_product_unit', 0, N'', N'', N'', N'1', N'2023-12-05 23:02:57', N'1', N'2023-12-05 23:02:57', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1464, 4, N'鎶?, N'4', N'crm_product_unit', 0, N'', N'', N'', N'1', N'2023-12-05 23:03:05', N'1', N'2023-12-05 23:03:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1465, 5, N'鏋?, N'5', N'crm_product_unit', 0, N'', N'', N'', N'1', N'2023-12-05 23:03:14', N'1', N'2023-12-05 23:03:14', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1466, 6, N'鐡?, N'6', N'crm_product_unit', 0, N'', N'', N'', N'1', N'2023-12-05 23:03:20', N'1', N'2023-12-05 23:03:20', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1467, 7, N'鐩?, N'7', N'crm_product_unit', 0, N'', N'', N'', N'1', N'2023-12-05 23:03:30', N'1', N'2023-12-05 23:03:30', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1468, 8, N'鍙?, N'8', N'crm_product_unit', 0, N'', N'', N'', N'1', N'2023-12-05 23:03:41', N'1', N'2023-12-05 23:03:41', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1469, 9, N'鍚?, N'9', N'crm_product_unit', 0, N'', N'', N'', N'1', N'2023-12-05 23:03:48', N'1', N'2023-12-05 23:03:48', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1470, 10, N'鍗冨厠', N'10', N'crm_product_unit', 0, N'', N'', N'', N'1', N'2023-12-05 23:04:03', N'1', N'2023-12-05 23:04:03', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1471, 11, N'绫?, N'11', N'crm_product_unit', 0, N'', N'', N'', N'1', N'2023-12-05 23:04:12', N'1', N'2023-12-05 23:04:12', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1472, 12, N'绠?, N'12', N'crm_product_unit', 0, N'', N'', N'', N'1', N'2023-12-05 23:04:25', N'1', N'2023-12-05 23:04:25', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1473, 13, N'濂?, N'13', N'crm_product_unit', 0, N'', N'', N'', N'1', N'2023-12-05 23:04:34', N'1', N'2023-12-05 23:04:34', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1474, 1, N'鎵撶數璇?, N'1', N'crm_follow_up_type', 0, N'', N'', N'', N'1', N'2024-01-15 20:48:20', N'1', N'2024-01-15 20:48:20', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1475, 2, N'鍙戠煭淇?, N'2', N'crm_follow_up_type', 0, N'', N'', N'', N'1', N'2024-01-15 20:48:31', N'1', N'2024-01-15 20:48:31', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1476, 3, N'涓婇棬鎷滆', N'3', N'crm_follow_up_type', 0, N'', N'', N'', N'1', N'2024-01-15 20:49:07', N'1', N'2024-01-15 20:49:07', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1477, 4, N'寰俊娌熼€?, N'4', N'crm_follow_up_type', 0, N'', N'', N'', N'1', N'2024-01-15 20:49:15', N'1', N'2024-01-15 20:49:15', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1482, 4, N'杞处澶辫触', N'20', N'pay_transfer_status', 0, N'warning', N'', N'', N'1', N'2023-10-28 16:24:16', N'1', N'2025-05-08 12:59:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1483, 3, N'杞处鎴愬姛', N'10', N'pay_transfer_status', 0, N'success', N'', N'', N'1', N'2023-10-28 16:23:50', N'1', N'2025-05-08 12:58:58', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1484, 2, N'杞处杩涜涓?, N'5', N'pay_transfer_status', 0, N'info', N'', N'', N'1', N'2023-10-28 16:23:12', N'1', N'2025-05-08 12:58:54', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1485, 1, N'绛夊緟杞处', N'0', N'pay_transfer_status', 0, N'default', N'', N'', N'1', N'2023-10-28 16:21:43', N'1', N'2023-10-28 16:23:22', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1486, 10, N'鍏跺畠鍏ュ簱', N'10', N'erp_stock_record_biz_type', 0, N'', N'', N'', N'1', N'2024-02-05 18:07:25', N'1', N'2024-02-05 18:07:43', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1487, 11, N'鍏跺畠鍏ュ簱锛堜綔搴燂級', N'11', N'erp_stock_record_biz_type', 0, N'danger', N'', N'', N'1', N'2024-02-05 18:08:07', N'1', N'2024-02-05 19:20:16', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1488, 20, N'鍏跺畠鍑哄簱', N'20', N'erp_stock_record_biz_type', 0, N'', N'', N'', N'1', N'2024-02-05 18:08:51', N'1', N'2024-02-05 18:08:51', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1489, 21, N'鍏跺畠鍑哄簱锛堜綔搴燂級', N'21', N'erp_stock_record_biz_type', 0, N'danger', N'', N'', N'1', N'2024-02-05 18:09:00', N'1', N'2024-02-05 19:20:10', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1490, 10, N'鏈鏍?, N'10', N'erp_audit_status', 0, N'default', N'', N'', N'1', N'2024-02-06 00:00:21', N'1', N'2024-02-06 00:00:21', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1491, 20, N'宸插鏍?, N'20', N'erp_audit_status', 0, N'success', N'', N'', N'1', N'2024-02-06 00:00:35', N'1', N'2024-02-06 00:00:35', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1492, 30, N'璋冩嫧鍏ュ簱', N'30', N'erp_stock_record_biz_type', 0, N'', N'', N'', N'1', N'2024-02-07 20:34:19', N'1', N'2024-02-07 12:36:31', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1493, 31, N'璋冩嫧鍏ュ簱锛堜綔搴燂級', N'31', N'erp_stock_record_biz_type', 0, N'danger', N'', N'', N'1', N'2024-02-07 20:34:29', N'1', N'2024-02-07 20:37:11', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1494, 32, N'璋冩嫧鍑哄簱', N'32', N'erp_stock_record_biz_type', 0, N'', N'', N'', N'1', N'2024-02-07 20:34:38', N'1', N'2024-02-07 12:36:33', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1495, 33, N'璋冩嫧鍑哄簱锛堜綔搴燂級', N'33', N'erp_stock_record_biz_type', 0, N'danger', N'', N'', N'1', N'2024-02-07 20:34:49', N'1', N'2024-02-07 20:37:06', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1496, 40, N'鐩樼泩鍏ュ簱', N'40', N'erp_stock_record_biz_type', 0, N'', N'', N'', N'1', N'2024-02-08 08:53:00', N'1', N'2024-02-08 08:53:09', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1497, 41, N'鐩樼泩鍏ュ簱锛堜綔搴燂級', N'41', N'erp_stock_record_biz_type', 0, N'danger', N'', N'', N'1', N'2024-02-08 08:53:39', N'1', N'2024-02-16 19:40:54', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1498, 42, N'鐩樹簭鍑哄簱', N'42', N'erp_stock_record_biz_type', 0, N'', N'', N'', N'1', N'2024-02-08 08:54:16', N'1', N'2024-02-08 08:54:16', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1499, 43, N'鐩樹簭鍑哄簱锛堜綔搴燂級', N'43', N'erp_stock_record_biz_type', 0, N'danger', N'', N'', N'1', N'2024-02-08 08:54:31', N'1', N'2024-02-16 19:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1500, 50, N'閿€鍞嚭搴?, N'50', N'erp_stock_record_biz_type', 0, N'', N'', N'', N'1', N'2024-02-11 21:47:25', N'1', N'2024-02-11 21:50:40', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1501, 51, N'閿€鍞嚭搴擄紙浣滃簾锛?, N'51', N'erp_stock_record_biz_type', 0, N'danger', N'', N'', N'1', N'2024-02-11 21:47:37', N'1', N'2024-02-11 21:51:12', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1502, 60, N'閿€鍞€€璐у叆搴?, N'60', N'erp_stock_record_biz_type', 0, N'', N'', N'', N'1', N'2024-02-12 06:51:05', N'1', N'2024-02-12 06:51:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1503, 61, N'閿€鍞€€璐у叆搴擄紙浣滃簾锛?, N'61', N'erp_stock_record_biz_type', 0, N'danger', N'', N'', N'1', N'2024-02-12 06:51:18', N'1', N'2024-02-12 06:51:18', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1504, 70, N'閲囪喘鍏ュ簱', N'70', N'erp_stock_record_biz_type', 0, N'', N'', N'', N'1', N'2024-02-16 13:10:02', N'1', N'2024-02-16 13:10:02', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1505, 71, N'閲囪喘鍏ュ簱锛堜綔搴燂級', N'71', N'erp_stock_record_biz_type', 0, N'danger', N'', N'', N'1', N'2024-02-16 13:10:10', N'1', N'2024-02-16 19:40:40', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1506, 80, N'閲囪喘閫€璐у嚭搴?, N'80', N'erp_stock_record_biz_type', 0, N'', N'', N'', N'1', N'2024-02-16 13:10:17', N'1', N'2024-02-16 13:10:17', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1507, 81, N'閲囪喘閫€璐у嚭搴擄紙浣滃簾锛?, N'81', N'erp_stock_record_biz_type', 0, N'danger', N'', N'', N'1', N'2024-02-16 13:10:26', N'1', N'2024-02-16 19:40:33', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1509, 3, N'瀹℃壒涓嶉€氳繃', N'3', N'bpm_process_instance_status', 0, N'danger', N'', N'', N'1', N'2024-03-16 16:12:06', N'1', N'2024-03-16 16:12:06', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1510, 4, N'宸插彇娑?, N'4', N'bpm_process_instance_status', 0, N'warning', N'', N'', N'1', N'2024-03-16 16:12:22', N'1', N'2024-03-16 16:12:22', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1511, 5, N'宸查€€鍥?, N'5', N'bpm_task_status', 0, N'warning', N'', N'', N'1', N'2024-03-16 19:10:46', N'1', N'2024-03-08 22:41:40', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1512, 6, N'濮旀淳涓?, N'6', N'bpm_task_status', 0, N'primary', N'', N'', N'1', N'2024-03-17 10:06:22', N'1', N'2024-03-08 22:41:40', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1513, 7, N'瀹℃壒閫氳繃涓?, N'7', N'bpm_task_status', 0, N'success', N'', N'', N'1', N'2024-03-17 10:06:47', N'1', N'2024-03-08 22:41:41', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1514, 0, N'寰呭鎵?, N'0', N'bpm_task_status', 0, N'info', N'', N'', N'1', N'2024-03-17 10:07:11', N'1', N'2024-03-08 22:41:42', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1515, 35, N'鍙戣捣浜鸿嚜閫?, N'35', N'bpm_task_candidate_strategy', 0, N'', N'', N'', N'1', N'2024-03-22 19:45:16', N'1', N'2024-03-22 19:45:16', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1516, 1, N'鎵ц鐩戝惉鍣?, N'execution', N'bpm_process_listener_type', 0, N'primary', N'', N'', N'1', N'2024-03-23 12:54:03', N'1', N'2024-03-23 19:14:19', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1517, 1, N'浠诲姟鐩戝惉鍣?, N'task', N'bpm_process_listener_type', 0, N'success', N'', N'', N'1', N'2024-03-23 12:54:13', N'1', N'2024-03-23 19:14:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1526, 1, N'Java 绫?, N'class', N'bpm_process_listener_value_type', 0, N'primary', N'', N'', N'1', N'2024-03-23 15:08:45', N'1', N'2024-03-23 19:14:32', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1527, 2, N'琛ㄨ揪寮?, N'expression', N'bpm_process_listener_value_type', 0, N'success', N'', N'', N'1', N'2024-03-23 15:09:06', N'1', N'2024-03-23 19:14:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1528, 3, N'浠ｇ悊琛ㄨ揪寮?, N'delegateExpression', N'bpm_process_listener_value_type', 0, N'info', N'', N'', N'1', N'2024-03-23 15:11:23', N'1', N'2024-03-23 19:14:41', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1529, 1, N'澶?, N'1', N'date_interval', 0, N'', N'', N'', N'1', N'2024-03-29 22:50:26', N'1', N'2024-03-29 22:50:26', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1530, 2, N'鍛?, N'2', N'date_interval', 0, N'', N'', N'', N'1', N'2024-03-29 22:50:36', N'1', N'2024-03-29 22:50:36', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1531, 3, N'鏈?, N'3', N'date_interval', 0, N'', N'', N'', N'1', N'2024-03-29 22:50:46', N'1', N'2024-03-29 22:50:54', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1532, 4, N'瀛ｅ害', N'4', N'date_interval', 0, N'', N'', N'', N'1', N'2024-03-29 22:51:01', N'1', N'2024-03-29 22:51:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1533, 5, N'骞?, N'5', N'date_interval', 0, N'', N'', N'', N'1', N'2024-03-29 22:51:07', N'1', N'2024-03-29 22:51:07', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1534, 1, N'璧㈠崟', N'1', N'crm_business_end_status_type', 0, N'success', N'', N'', N'1', N'2024-04-13 23:26:57', N'1', N'2024-04-13 23:26:57', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1535, 2, N'杈撳崟', N'2', N'crm_business_end_status_type', 0, N'primary', N'', N'', N'1', N'2024-04-13 23:27:31', N'1', N'2024-04-13 23:27:31', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1536, 3, N'鏃犳晥', N'3', N'crm_business_end_status_type', 0, N'info', N'', N'', N'1', N'2024-04-13 23:27:59', N'1', N'2024-04-13 23:27:59', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1537, 1, N'OpenAI', N'OpenAI', N'ai_platform', 0, N'', N'', N'', N'1', N'2024-05-09 22:33:47', N'1', N'2024-05-09 22:58:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1538, 2, N'Ollama', N'Ollama', N'ai_platform', 0, N'', N'', N'', N'1', N'2024-05-17 23:02:55', N'1', N'2024-05-17 23:02:55', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1539, 3, N'鏂囧績涓€瑷€', N'YiYan', N'ai_platform', 0, N'', N'', N'', N'1', N'2024-05-18 09:24:20', N'1', N'2024-05-18 09:29:01', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1540, 4, N'璁鏄熺伀', N'XingHuo', N'ai_platform', 0, N'', N'', N'', N'1', N'2024-05-18 10:08:56', N'1', N'2024-05-18 10:08:56', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1541, 5, N'閫氫箟鍗冮棶', N'TongYi', N'ai_platform', 0, N'', N'', N'', N'1', N'2024-05-18 10:32:29', N'1', N'2024-07-06 15:42:29', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1542, 6, N'StableDiffusion', N'StableDiffusion', N'ai_platform', 0, N'', N'', N'', N'1', N'2024-06-01 15:09:31', N'1', N'2024-06-01 15:10:25', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1543, 10, N'杩涜涓?, N'10', N'ai_image_status', 0, N'primary', N'', N'', N'1', N'2024-06-26 20:51:41', N'1', N'2024-06-26 20:52:48', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1544, 20, N'宸插畬鎴?, N'20', N'ai_image_status', 0, N'success', N'', N'', N'1', N'2024-06-26 20:52:07', N'1', N'2024-06-26 20:52:41', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1545, 30, N'宸插け璐?, N'30', N'ai_image_status', 0, N'warning', N'', N'', N'1', N'2024-06-26 20:52:25', N'1', N'2024-06-26 20:52:35', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1546, 7, N'Midjourney', N'Midjourney', N'ai_platform', 0, N'', N'', N'', N'1', N'2024-06-26 22:14:46', N'1', N'2024-06-26 22:14:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1547, 10, N'杩涜涓?, N'10', N'ai_music_status', 0, N'primary', N'', N'', N'1', N'2024-06-27 22:45:22', N'1', N'2024-06-28 00:56:17', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1548, 20, N'宸插畬鎴?, N'20', N'ai_music_status', 0, N'success', N'', N'', N'1', N'2024-06-27 22:45:33', N'1', N'2024-06-28 00:56:18', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1549, 30, N'宸插け璐?, N'30', N'ai_music_status', 0, N'danger', N'', N'', N'1', N'2024-06-27 22:45:44', N'1', N'2024-06-28 00:56:19', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1550, 1, N'姝岃瘝妯″紡', N'1', N'ai_generate_mode', 0, N'', N'', N'', N'1', N'2024-06-27 22:46:31', N'1', N'2024-06-28 01:22:25', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1551, 2, N'鎻忚堪妯″紡', N'2', N'ai_generate_mode', 0, N'', N'', N'', N'1', N'2024-06-27 22:46:37', N'1', N'2024-06-28 01:22:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1552, 8, N'Suno', N'Suno', N'ai_platform', 0, N'', N'', N'', N'1', N'2024-06-29 09:13:36', N'1', N'2024-06-29 09:13:41', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1553, 9, N'DeepSeek', N'DeepSeek', N'ai_platform', 0, N'', N'', N'', N'1', N'2024-07-06 12:04:30', N'1', N'2024-07-06 12:05:20', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1554, 13, N'鏅鸿氨', N'ZhiPu', N'ai_platform', 0, N'', N'', N'', N'1', N'2024-07-06 18:00:35', N'1', N'2025-02-24 20:18:41', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1555, 4, N'闀?, N'4', N'ai_write_length', 0, N'', N'', N'', N'1', N'2024-07-07 15:49:03', N'1', N'2024-07-07 15:49:03', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1556, 5, N'娈佃惤', N'5', N'ai_write_format', 0, N'', N'', N'', N'1', N'2024-07-07 15:49:54', N'1', N'2024-07-07 15:49:54', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1557, 6, N'鏂囩珷', N'6', N'ai_write_format', 0, N'', N'', N'', N'1', N'2024-07-07 15:50:05', N'1', N'2024-07-07 15:50:05', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1558, 7, N'鍗氬鏂囩珷', N'7', N'ai_write_format', 0, N'', N'', N'', N'1', N'2024-07-07 15:50:23', N'1', N'2024-07-07 15:50:23', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1559, 8, N'鎯虫硶', N'8', N'ai_write_format', 0, N'', N'', N'', N'1', N'2024-07-07 15:50:31', N'1', N'2024-07-07 15:50:31', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1560, 9, N'澶х翰', N'9', N'ai_write_format', 0, N'', N'', N'', N'1', N'2024-07-07 15:50:37', N'1', N'2024-07-07 15:50:37', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1561, 1, N'鑷姩', N'1', N'ai_write_tone', 0, N'', N'', N'', N'1', N'2024-07-07 15:51:06', N'1', N'2024-07-07 15:51:06', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1562, 2, N'鍙嬪杽', N'2', N'ai_write_tone', 0, N'', N'', N'', N'1', N'2024-07-07 15:51:19', N'1', N'2024-07-07 15:51:19', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1563, 3, N'闅忔剰', N'3', N'ai_write_tone', 0, N'', N'', N'', N'1', N'2024-07-07 15:51:27', N'1', N'2024-07-07 15:51:27', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1564, 4, N'鍙嬪ソ', N'4', N'ai_write_tone', 0, N'', N'', N'', N'1', N'2024-07-07 15:51:37', N'1', N'2024-07-07 15:51:37', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1565, 5, N'涓撲笟', N'5', N'ai_write_tone', 0, N'', N'', N'', N'1', N'2024-07-07 15:51:49', N'1', N'2024-07-07 15:52:02', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1566, 6, N'璇欒皭', N'6', N'ai_write_tone', 0, N'', N'', N'', N'1', N'2024-07-07 15:52:15', N'1', N'2024-07-07 15:52:15', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1567, 7, N'鏈夎叮', N'7', N'ai_write_tone', 0, N'', N'', N'', N'1', N'2024-07-07 15:52:24', N'1', N'2024-07-07 15:52:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1568, 8, N'姝ｅ紡', N'8', N'ai_write_tone', 0, N'', N'', N'', N'1', N'2024-07-07 15:54:33', N'1', N'2024-07-07 15:54:33', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1569, 5, N'娈佃惤', N'5', N'ai_write_format', 0, N'', N'', N'', N'1', N'2024-07-07 15:49:54', N'1', N'2024-07-07 15:49:54', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1570, 1, N'鑷姩', N'1', N'ai_write_format', 0, N'', N'', N'', N'1', N'2024-07-07 15:19:34', N'1', N'2024-07-07 15:19:34', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1571, 2, N'鐢靛瓙閭欢', N'2', N'ai_write_format', 0, N'', N'', N'', N'1', N'2024-07-07 15:19:50', N'1', N'2024-07-07 15:49:30', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1572, 3, N'娑堟伅', N'3', N'ai_write_format', 0, N'', N'', N'', N'1', N'2024-07-07 15:20:01', N'1', N'2024-07-07 15:49:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1573, 4, N'璇勮', N'4', N'ai_write_format', 0, N'', N'', N'', N'1', N'2024-07-07 15:20:13', N'1', N'2024-07-07 15:49:45', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1574, 1, N'鑷姩', N'1', N'ai_write_language', 0, N'', N'', N'', N'1', N'2024-07-07 15:44:18', N'1', N'2024-07-07 15:44:18', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1575, 2, N'涓枃', N'2', N'ai_write_language', 0, N'', N'', N'', N'1', N'2024-07-07 15:44:28', N'1', N'2024-07-07 15:44:28', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1576, 3, N'鑻辨枃', N'3', N'ai_write_language', 0, N'', N'', N'', N'1', N'2024-07-07 15:44:37', N'1', N'2024-07-07 15:44:37', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1577, 4, N'闊╄', N'4', N'ai_write_language', 0, N'', N'', N'', N'1', N'2024-07-07 15:46:28', N'1', N'2024-07-07 15:46:28', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1578, 5, N'鏃ヨ', N'5', N'ai_write_language', 0, N'', N'', N'', N'1', N'2024-07-07 15:46:44', N'1', N'2024-07-07 15:46:44', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1579, 1, N'鑷姩', N'1', N'ai_write_length', 0, N'', N'', N'', N'1', N'2024-07-07 15:48:34', N'1', N'2024-07-07 15:48:34', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1580, 2, N'鐭?, N'2', N'ai_write_length', 0, N'', N'', N'', N'1', N'2024-07-07 15:48:44', N'1', N'2024-07-07 15:48:44', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1581, 3, N'涓瓑', N'3', N'ai_write_length', 0, N'', N'', N'', N'1', N'2024-07-07 15:48:52', N'1', N'2024-07-07 15:48:52', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1582, 4, N'闀?, N'4', N'ai_write_length', 0, N'', N'', N'', N'1', N'2024-07-07 15:49:03', N'1', N'2024-07-07 15:49:03', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1584, 1, N'鎾板啓', N'1', N'ai_write_type', 0, N'', N'', N'', N'1', N'2024-07-10 21:26:00', N'1', N'2024-07-10 21:26:00', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1585, 2, N'鍥炲', N'2', N'ai_write_type', 0, N'', N'', N'', N'1', N'2024-07-10 21:26:06', N'1', N'2024-07-10 21:26:06', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1586, 2, N'鑵捐浜?, N'TENCENT', N'system_sms_channel_code', 0, N'', N'', N'', N'1', N'2024-07-22 22:23:16', N'1', N'2024-07-22 22:23:16', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1587, 3, N'鍗庝负浜?, N'HUAWEI', N'system_sms_channel_code', 0, N'', N'', N'', N'1', N'2024-07-22 22:23:46', N'1', N'2024-07-22 22:23:53', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1588, 1, N'OpenAI 寰蒋', N'AzureOpenAI', N'ai_platform', 0, N'', N'', N'', N'1', N'2024-08-10 14:07:41', N'1', N'2024-08-10 14:07:41', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1589, 10, N'BPMN 璁捐鍣?, N'10', N'bpm_model_type', 0, N'primary', N'', N'', N'1', N'2024-08-26 15:22:17', N'1', N'2024-08-26 16:46:02', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1590, 20, N'SIMPLE 璁捐鍣?, N'20', N'bpm_model_type', 0, N'success', N'', N'', N'1', N'2024-08-26 15:22:27', N'1', N'2024-08-26 16:45:58', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1591, 4, N'涓冪墰浜?, N'QINIU', N'system_sms_channel_code', 0, N'', N'', N'', N'1', N'2024-08-31 08:45:03', N'1', N'2024-08-31 08:45:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1592, 3, N'鏂颁汉鍒?, N'3', N'promotion_coupon_take_type', 0, N'info', N'', N'鏂颁汉娉ㄥ唽鍚庯紝鑷姩鍙戞斁', N'1', N'2024-09-03 11:57:16', N'1', N'2024-09-03 11:57:28', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1593, 5, N'寰俊闆堕挶', N'5', N'brokerage_withdraw_type', 0, N'', N'', N'API 鎵撴', N'1', N'2024-10-13 11:06:48', N'1', N'2025-05-10 08:24:55', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1683, 10, N'瀛楄妭璞嗗寘', N'DouBao', N'ai_platform', 0, N'', N'', N'', N'1', N'2025-02-23 19:51:40', N'1', N'2025-02-23 19:52:02', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1684, 11, N'鑵捐娣峰厓', N'HunYuan', N'ai_platform', 0, N'', N'', N'', N'1', N'2025-02-23 20:58:04', N'1', N'2025-02-23 20:58:04', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1685, 12, N'纭呭熀娴佸姩', N'SiliconFlow', N'ai_platform', 0, N'', N'', N'', N'1', N'2025-02-24 20:19:09', N'1', N'2025-02-24 20:19:09', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1686, 1, N'鑱婂ぉ', N'1', N'ai_model_type', 0, N'', N'', N'', N'1', N'2025-03-03 12:26:34', N'1', N'2025-03-03 12:26:34', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1687, 2, N'鍥惧儚', N'2', N'ai_model_type', 0, N'', N'', N'', N'1', N'2025-03-03 12:27:23', N'1', N'2025-03-03 12:27:23', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1688, 3, N'闊抽', N'3', N'ai_model_type', 0, N'', N'', N'', N'1', N'2025-03-03 12:27:51', N'1', N'2025-03-03 12:27:51', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1689, 4, N'瑙嗛', N'4', N'ai_model_type', 0, N'', N'', N'', N'1', N'2025-03-03 12:28:03', N'1', N'2025-03-03 12:28:03', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1690, 5, N'鍚戦噺', N'5', N'ai_model_type', 0, N'', N'', N'', N'1', N'2025-03-03 12:28:15', N'1', N'2025-03-03 12:28:15', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1691, 6, N'閲嶆帓', N'6', N'ai_model_type', 0, N'', N'', N'', N'1', N'2025-03-03 12:28:26', N'1', N'2025-03-03 12:28:26', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1692, 14, N'MiniMax', N'MiniMax', N'ai_platform', 0, N'', N'', N'', N'1', N'2025-03-11 20:04:51', N'1', N'2025-03-11 20:04:51', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (1693, 15, N'鏈堜箣鏆楅潰', N'Moonshot', N'ai_platform', 0, N'', N'', N'', N'1', N'2025-03-11 20:05:08', N'1', N'2025-03-11 20:05:08', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2000, 0, N'鏍囧噯鏁版嵁鏍煎紡锛圝SON锛?, N'0', N'iot_data_format', 0, N'default', N'', N'', N'1', N'2024-08-10 11:53:26', N'1', N'2025-03-17 09:28:16', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2001, 1, N'閫忎紶/鑷畾涔?, N'1', N'iot_data_format', 0, N'default', N'', N'', N'1', N'2024-08-10 11:53:37', N'1', N'2025-03-17 09:28:19', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2002, 0, N'鐩磋繛璁惧', N'0', N'iot_product_device_type', 0, N'default', N'', N'', N'1', N'2024-08-10 11:54:58', N'1', N'2025-03-17 09:28:22', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2003, 2, N'缃戝叧璁惧', N'2', N'iot_product_device_type', 0, N'default', N'', N'', N'1', N'2024-08-10 11:55:08', N'1', N'2025-03-17 09:28:28', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2004, 1, N'缃戝叧瀛愯澶?, N'1', N'iot_product_device_type', 0, N'default', N'', N'', N'1', N'2024-08-10 11:55:20', N'1', N'2025-03-17 09:28:31', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2005, 1, N'宸插彂甯?, N'1', N'iot_product_status', 0, N'success', N'', N'', N'1', N'2024-08-10 12:10:33', N'1', N'2025-03-17 09:28:34', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2006, 0, N'寮€鍙戜腑', N'0', N'iot_product_status', 0, N'default', N'', N'', N'1', N'2024-08-10 14:19:18', N'1', N'2025-03-17 09:28:39', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2007, 0, N'寮辨牎楠?, N'0', N'iot_validate_type', 0, N'', N'', N'', N'1', N'2024-09-06 20:05:48', N'1', N'2025-03-17 09:28:41', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2008, 1, N'鍏嶆牎楠?, N'1', N'iot_validate_type', 0, N'', N'', N'', N'1', N'2024-09-06 20:06:03', N'1', N'2025-03-17 09:28:44', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2009, 0, N'Wi-Fi', N'0', N'iot_net_type', 0, N'', N'', N'', N'1', N'2024-09-06 22:04:47', N'1', N'2025-03-17 09:28:47', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2010, 1, N'铚傜獫锛?G / 3G / 4G / 5G锛?, N'1', N'iot_net_type', 0, N'', N'', N'', N'1', N'2024-09-06 22:05:14', N'1', N'2025-03-17 09:28:49', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2011, 2, N'浠ュお缃?, N'2', N'iot_net_type', 0, N'', N'', N'', N'1', N'2024-09-06 22:05:35', N'1', N'2025-03-17 09:28:51', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2012, 3, N'鍏朵粬', N'3', N'iot_net_type', 0, N'', N'', N'', N'1', N'2024-09-06 22:05:52', N'1', N'2025-03-17 09:28:54', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2013, 0, N'鑷畾涔?, N'0', N'iot_protocol_type', 0, N'', N'', N'', N'1', N'2024-09-06 22:26:10', N'1', N'2025-03-17 09:28:56', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2014, 1, N'Modbus', N'1', N'iot_protocol_type', 0, N'', N'', N'', N'1', N'2024-09-06 22:26:21', N'1', N'2025-03-17 09:28:58', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2015, 2, N'OPC UA', N'2', N'iot_protocol_type', 0, N'', N'', N'', N'1', N'2024-09-06 22:26:31', N'1', N'2025-03-17 09:29:00', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2016, 3, N'ZigBee', N'3', N'iot_protocol_type', 0, N'', N'', N'', N'1', N'2024-09-06 22:26:39', N'1', N'2025-03-17 09:29:04', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2017, 4, N'BLE', N'4', N'iot_protocol_type', 0, N'', N'', N'', N'1', N'2024-09-06 22:26:48', N'1', N'2025-03-17 09:29:06', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2018, 0, N'鏈縺娲?, N'0', N'iot_device_state', 0, N'', N'', N'', N'1', N'2024-09-21 08:13:34', N'1', N'2025-03-17 09:29:09', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2019, 1, N'鍦ㄧ嚎', N'1', N'iot_device_state', 0, N'', N'', N'', N'1', N'2024-09-21 08:13:48', N'1', N'2025-03-17 09:29:12', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2020, 2, N'绂荤嚎', N'2', N'iot_device_state', 0, N'', N'', N'', N'1', N'2024-09-21 08:13:59', N'1', N'2025-03-17 09:29:14', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2021, 1, N'灞炴€?, N'1', N'iot_thing_model_type', 0, N'', N'', N'', N'1', N'2024-09-29 20:03:01', N'1', N'2025-03-17 09:29:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2022, 2, N'鏈嶅姟', N'2', N'iot_thing_model_type', 0, N'', N'', N'', N'1', N'2024-09-29 20:03:11', N'1', N'2025-03-17 09:29:27', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2023, 3, N'浜嬩欢', N'3', N'iot_thing_model_type', 0, N'', N'', N'', N'1', N'2024-09-29 20:03:20', N'1', N'2025-03-17 09:29:29', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2024, 1, N'JAR 閮ㄧ讲', N'0', N'iot_plugin_deploy_type', 0, N'', N'', N'', N'1', N'2024-12-13 10:55:32', N'1', N'2025-03-17 09:29:32', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2025, 2, N'鐙珛閮ㄧ讲', N'1', N'iot_plugin_deploy_type', 0, N'', N'', N'', N'1', N'2024-12-13 10:55:43', N'1', N'2025-03-17 09:29:34', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2026, 0, N'鍋滄', N'0', N'iot_plugin_status', 0, N'danger', N'', N'', N'1', N'2024-12-13 11:07:37', N'1', N'2025-03-17 09:29:37', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2027, 1, N'杩愯', N'1', N'iot_plugin_status', 0, N'', N'', N'', N'1', N'2024-12-13 11:07:45', N'1', N'2025-03-17 09:34:17', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2028, 0, N'鏅€氭彃浠?, N'0', N'iot_plugin_type', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:32', N'1', N'2025-03-17 09:34:19', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2029, 1, N'璁惧鎻掍欢', N'1', N'iot_plugin_type', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:34:22', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2030, 1, N'鍗囨瘡鍒嗛挓', N'L/min', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:34:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2031, 2, N'姣厠姣忓崈鍏?, N'mg/kg', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:34:27', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2032, 3, N'娴婂害', N'NTU', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:34:31', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2033, 4, N'PH鍊?, N'pH', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:34:36', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2034, 5, N'鍦熷￥EC鍊?, N'dS/m', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:34:43', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2035, 6, N'澶槼鎬昏緪灏?, N'W/銕?, N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:36:20', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2036, 7, N'闄嶉洦閲?, N'mm/hour', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:36:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2037, 8, N'涔?, N'var', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:36:27', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2038, 9, N'鍘樻硦', N'cP', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:36:33', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2039, 10, N'楗卞拰搴?, N'aw', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:37:11', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2040, 11, N'涓?, N'pcs', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:37:19', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2041, 12, N'鍘樻柉', N'cst', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:37:22', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2042, 13, N'宸?, N'bar', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:37:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2043, 14, N'绾冲厠姣忓崌', N'ppt', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:37:27', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2044, 15, N'寰厠姣忓崌', N'ppb', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:37:31', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2045, 16, N'寰タ姣忓帢绫?, N'uS/cm', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:37:34', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2046, 17, N'鐗涢】姣忓簱浠?, N'N/C', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:37:38', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2047, 18, N'浼忕壒姣忕背', N'V/m', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:37:43', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2048, 19, N'婊撮€?, N'ml/min', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:37:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2049, 20, N'姣背姹炴煴', N'mmHg', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:37:48', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2050, 21, N'琛€绯?, N'mmol/L', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:37:54', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2051, 22, N'姣背姣忕', N'mm/s', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:38:02', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2052, 23, N'杞瘡鍒嗛挓', N'turn/m', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:38:07', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2053, 24, N'娆?, N'count', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:38:09', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2054, 25, N'妗?, N'gear', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:38:11', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2055, 26, N'姝?, N'stepCount', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:38:13', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2056, 27, N'鏍囧噯绔嬫柟绫虫瘡灏忔椂', N'Nm3/h', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:38:15', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2057, 28, N'鍗冧紡', N'kV', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:38:20', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2058, 29, N'鍗冧紡瀹?, N'kVA', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:38:24', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2060, 30, N'鍗冧箯', N'kVar', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2061, 31, N'寰摝姣忓钩鏂瑰帢绫?, N'uw/cm2', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2062, 32, N'鍙?, N'鍙?, N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2063, 33, N'鐩稿婀垮害', N'%RH', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2064, 34, N'绔嬫柟绫虫瘡绉?, N'm鲁/s', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2065, 35, N'鍏枻姣忕', N'kg/s', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2066, 36, N'杞瘡鍒嗛挓', N'r/min', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2067, 37, N'鍚ㄦ瘡灏忔椂', N't/h', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2068, 38, N'鍗冨崱姣忓皬鏃?, N'KCL/h', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2069, 39, N'鍗囨瘡绉?, N'L/s', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2070, 40, N'鍏嗗笗', N'Mpa', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2071, 41, N'绔嬫柟绫虫瘡灏忔椂', N'm鲁/h', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2072, 42, N'鍗冧箯鏃?, N'kvarh', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2073, 43, N'寰厠姣忓崌', N'渭g/L', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2074, 44, N'鍗冨崱璺噷', N'kcal', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2075, 45, N'鍚夊瓧鑺?, N'GB', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2076, 46, N'鍏嗗瓧鑺?, N'MB', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2077, 47, N'鍗冨瓧鑺?, N'KB', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2078, 48, N'瀛楄妭', N'B', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2079, 49, N'寰厠姣忓钩鏂瑰垎绫虫瘡澶?, N'渭g/(d銕÷穌)', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2080, 50, N'鏃?, N'', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2081, 51, N'鐧句竾鍒嗙巼', N'ppm', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2082, 52, N'鍍忕礌', N'pixel', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2083, 53, N'鐓у害', N'Lux', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2084, 54, N'閲嶅姏鍔犻€熷害', N'grav', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2085, 55, N'鍒嗚礉', N'dB', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2086, 56, N'鐧惧垎姣?, N'%', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2087, 57, N'娴佹槑', N'lm', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2088, 58, N'姣旂壒', N'bit', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2089, 59, N'鍏嬫瘡姣崌', N'g/mL', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2090, 60, N'鍏嬫瘡鍗?, N'g/L', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2091, 61, N'姣厠姣忓崌', N'mg/L', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2092, 62, N'寰厠姣忕珛鏂圭背', N'渭g/m鲁', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2093, 63, N'姣厠姣忕珛鏂圭背', N'mg/m鲁', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2094, 64, N'鍏嬫瘡绔嬫柟绫?, N'g/m鲁', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2095, 65, N'鍗冨厠姣忕珛鏂圭背', N'kg/m鲁', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2096, 66, N'绾虫硶', N'nF', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2097, 67, N'鐨硶', N'pF', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2098, 68, N'寰硶', N'渭F', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2099, 69, N'娉曟媺', N'F', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2100, 70, N'娆у', N'惟', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2101, 71, N'寰畨', N'渭A', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2102, 72, N'姣畨', N'mA', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2103, 73, N'鍗冨畨', N'kA', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2104, 74, N'瀹夊煿', N'A', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2105, 75, N'姣紡', N'mV', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2106, 76, N'浼忕壒', N'V', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2107, 77, N'姣', N'ms', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2108, 78, N'绉?, N's', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2109, 79, N'鍒嗛挓', N'min', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2110, 80, N'灏忔椂', N'h', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2111, 81, N'鏃?, N'day', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2112, 82, N'鍛?, N'week', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2113, 83, N'鏈?, N'month', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2114, 84, N'骞?, N'year', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2115, 85, N'鑺?, N'kn', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2116, 86, N'鍗冪背姣忓皬鏃?, N'km/h', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2117, 87, N'绫虫瘡绉?, N'm/s', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2118, 88, N'绉?, N'鈥?, N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2119, 89, N'鍒?, N'鈥?, N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2120, 90, N'搴?, N'掳', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2121, 91, N'寮у害', N'rad', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2122, 92, N'璧吂', N'Hz', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2123, 93, N'寰摝', N'渭W', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2124, 94, N'姣摝', N'mW', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2125, 95, N'鍗冪摝鐗?, N'kW', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2126, 96, N'鐡︾壒', N'W', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2127, 97, N'鍗¤矾閲?, N'cal', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2128, 98, N'鍗冪摝鏃?, N'kW路h', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2129, 99, N'鐡︽椂', N'Wh', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2130, 100, N'鐢靛瓙浼?, N'eV', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2131, 101, N'鍗冪劍', N'kJ', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2132, 102, N'鐒﹁€?, N'J', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2133, 103, N'鍗庢皬搴?, N'鈩?, N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2134, 104, N'寮€灏旀枃', N'K', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2135, 105, N'鍚?, N't', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2136, 106, N'鎽勬皬搴?, N'掳C', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2137, 107, N'姣笗', N'mPa', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2138, 108, N'鐧惧笗', N'hPa', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2139, 109, N'鍗冨笗', N'kPa', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2140, 110, N'甯曟柉鍗?, N'Pa', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2141, 111, N'姣厠', N'mg', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2142, 112, N'鍏?, N'g', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2143, 113, N'鍗冨厠', N'kg', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2144, 114, N'鐗?, N'N', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2145, 115, N'姣崌', N'mL', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2146, 116, N'鍗?, N'L', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2147, 117, N'绔嬫柟姣背', N'mm鲁', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2148, 118, N'绔嬫柟鍘樼背', N'cm鲁', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2149, 119, N'绔嬫柟鍗冪背', N'km鲁', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2150, 120, N'绔嬫柟绫?, N'm鲁', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2151, 121, N'鍏》', N'h銕?, N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2152, 122, N'骞虫柟鍘樼背', N'c銕?, N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2153, 123, N'骞虫柟姣背', N'm銕?, N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2154, 124, N'骞虫柟鍗冪背', N'k銕?, N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2155, 125, N'骞虫柟绫?, N'銕?, N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2156, 126, N'绾崇背', N'nm', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2157, 127, N'寰背', N'渭m', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2158, 128, N'姣背', N'mm', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2159, 129, N'鍘樼背', N'cm', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2160, 130, N'鍒嗙背', N'dm', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2161, 131, N'鍗冪背', N'km', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2162, 132, N'绫?, N'm', N'iot_thing_model_unit', 0, N'', N'', N'', N'1', N'2024-12-13 11:08:41', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2163, 1, N'杈撳叆', N'1', N'iot_data_bridge_direction_enum', 0, N'primary', N'', N'', N'1', N'2025-03-09 12:38:24', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2164, 2, N'杈撳嚭', N'2', N'iot_data_bridge_direction_enum', 0, N'primary', N'', N'', N'1', N'2025-03-09 12:38:36', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2165, 1, N'HTTP', N'1', N'iot_data_bridge_type_enum', 0, N'primary', N'', N'', N'1', N'2025-03-09 12:39:54', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2166, 2, N'TCP', N'2', N'iot_data_bridge_type_enum', 0, N'primary', N'', N'', N'1', N'2025-03-09 12:40:06', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2167, 3, N'WEBSOCKET', N'3', N'iot_data_bridge_type_enum', 0, N'primary', N'', N'', N'1', N'2025-03-09 12:40:24', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2168, 10, N'MQTT', N'10', N'iot_data_bridge_type_enum', 0, N'primary', N'', N'', N'1', N'2025-03-09 12:40:37', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2169, 20, N'DATABASE', N'20', N'iot_data_bridge_type_enum', 0, N'primary', N'', N'', N'1', N'2025-03-09 12:41:05', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2170, 21, N'REDIS_STREAM', N'21', N'iot_data_bridge_type_enum', 0, N'primary', N'', N'', N'1', N'2025-03-09 12:41:18', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2171, 30, N'ROCKETMQ', N'30', N'iot_data_bridge_type_enum', 0, N'primary', N'', N'', N'1', N'2025-03-09 12:41:30', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2172, 31, N'RABBITMQ', N'31', N'iot_data_bridge_type_enum', 0, N'primary', N'', N'', N'1', N'2025-03-09 12:41:47', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (2173, 32, N'KAFKA', N'32', N'iot_data_bridge_type_enum', 0, N'primary', N'', N'', N'1', N'2025-03-09 12:41:59', N'1', N'2025-03-17 09:40:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (3000, 16, N'鐧惧窛鏅鸿兘', N'BaiChuan', N'ai_platform', 0, N'', N'', N'', N'1', N'2025-03-23 12:15:46', N'1', N'2025-03-23 12:15:46', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (3001, 50, N'Vben5.0 Ant Design Schema 妯＄増', N'40', N'infra_codegen_front_type', 0, N'', N'', NULL, N'1', N'2025-04-23 21:47:47', N'1', N'2025-05-02 12:01:15', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (3002, 6, N'鏀粯瀹濅綑棰?, N'6', N'brokerage_withdraw_type', 0, N'', N'', N'API 鎵撴', N'1', N'2025-05-10 08:24:49', N'1', N'2025-05-10 08:24:49', N'0')
GO
INSERT INTO system_dict_data (id, sort, label, value, dict_type, status, color_type, css_class, remark, creator, create_time, updater, update_time, deleted) VALUES (3035, 40, N'鏀粯瀹濆皬绋嬪簭', N'40', N'system_social_type', 0, N'', N'', N'', N'1', N'2023-11-04 13:05:38', N'1', N'2023-11-04 13:07:16', N'0')
GO
SET IDENTITY_INSERT system_dict_data OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_dict_type
-- ----------------------------
DROP TABLE IF EXISTS system_dict_type
GO
CREATE TABLE system_dict_type
(
    id           bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name         nvarchar(100) DEFAULT ''                NOT NULL,
    type         nvarchar(100) DEFAULT ''                NOT NULL,
    status       tinyint       DEFAULT 0                 NOT NULL,
    remark       nvarchar(500) DEFAULT NULL              NULL,
    creator      nvarchar(64)  DEFAULT ''                NULL,
    create_time  datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater      nvarchar(64)  DEFAULT ''                NULL,
    update_time  datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted      bit           DEFAULT 0                 NOT NULL,
    deleted_time datetime2     DEFAULT NULL              NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楀吀涓婚敭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_type',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楀吀鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_type',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楀吀绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_type',
     'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_type',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶囨敞',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_type',
     'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_type',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_type',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_type',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_type',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_type',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒犻櫎鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_type',
     'COLUMN', N'deleted_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛楀吀绫诲瀷琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_dict_type'
GO

-- ----------------------------
-- Records of system_dict_type
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_dict_type ON
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1, N'鐢ㄦ埛鎬у埆', N'system_user_sex', 0, NULL, N'admin', N'2021-01-05 17:03:48', N'1', N'2022-05-16 20:29:32', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (6, N'鍙傛暟绫诲瀷', N'infra_config_type', 0, NULL, N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:36:54', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (7, N'閫氱煡绫诲瀷', N'system_notice_type', 0, NULL, N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:35:26', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (9, N'鎿嶄綔绫诲瀷', N'infra_operate_type', 0, NULL, N'admin', N'2021-01-05 17:03:48', N'1', N'2024-03-14 12:44:01', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (10, N'绯荤粺鐘舵€?, N'common_status', 0, NULL, N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-01 16:21:28', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (11, N'Boolean 鏄惁绫诲瀷', N'infra_boolean_string', 0, N'boolean 杞槸鍚?, N'', N'2021-01-19 03:20:08', N'', N'2022-02-01 16:37:10', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (104, N'鐧婚檰缁撴灉', N'system_login_result', 0, N'鐧婚檰缁撴灉', N'', N'2021-01-18 06:17:11', N'', N'2022-02-01 16:36:00', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (106, N'浠ｇ爜鐢熸垚妯℃澘绫诲瀷', N'infra_codegen_template_type', 0, NULL, N'', N'2021-02-05 07:08:06', N'1', N'2022-05-16 20:26:50', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (107, N'瀹氭椂浠诲姟鐘舵€?, N'infra_job_status', 0, NULL, N'', N'2021-02-07 07:44:16', N'', N'2022-02-01 16:51:11', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (108, N'瀹氭椂浠诲姟鏃ュ織鐘舵€?, N'infra_job_log_status', 0, NULL, N'', N'2021-02-08 10:03:51', N'', N'2022-02-01 16:50:43', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (109, N'鐢ㄦ埛绫诲瀷', N'user_type', 0, NULL, N'', N'2021-02-26 00:15:51', N'', N'2021-02-26 00:15:51', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (110, N'API 寮傚父鏁版嵁鐨勫鐞嗙姸鎬?, N'infra_api_error_log_process_status', 0, NULL, N'', N'2021-02-26 07:07:01', N'', N'2022-02-01 16:50:53', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (111, N'鐭俊娓犻亾缂栫爜', N'system_sms_channel_code', 0, NULL, N'1', N'2021-04-05 01:04:50', N'1', N'2022-02-16 02:09:08', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (112, N'鐭俊妯℃澘鐨勭被鍨?, N'system_sms_template_type', 0, NULL, N'1', N'2021-04-05 21:50:43', N'1', N'2022-02-01 16:35:06', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (113, N'鐭俊鍙戦€佺姸鎬?, N'system_sms_send_status', 0, NULL, N'1', N'2021-04-11 20:18:03', N'1', N'2022-02-01 16:35:09', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (114, N'鐭俊鎺ユ敹鐘舵€?, N'system_sms_receive_status', 0, NULL, N'1', N'2021-04-11 20:27:14', N'1', N'2022-02-01 16:35:14', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (116, N'鐧婚檰鏃ュ織鐨勭被鍨?, N'system_login_type', 0, N'鐧婚檰鏃ュ織鐨勭被鍨?, N'1', N'2021-10-06 00:50:46', N'1', N'2022-02-01 16:35:56', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (117, N'OA 璇峰亣绫诲瀷', N'bpm_oa_leave_type', 0, NULL, N'1', N'2021-09-21 22:34:33', N'1', N'2022-01-22 10:41:37', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (130, N'鏀粯娓犻亾缂栫爜绫诲瀷', N'pay_channel_code', 0, N'鏀粯娓犻亾鐨勭紪鐮?, N'1', N'2021-12-03 10:35:08', N'1', N'2023-07-10 10:11:39', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (131, N'鏀粯鍥炶皟鐘舵€?, N'pay_notify_status', 0, N'鏀粯鍥炶皟鐘舵€侊紙鍖呮嫭閫€娆惧洖璋冿級', N'1', N'2021-12-03 10:53:29', N'1', N'2023-07-19 18:09:43', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (132, N'鏀粯璁㈠崟鐘舵€?, N'pay_order_status', 0, N'鏀粯璁㈠崟鐘舵€?, N'1', N'2021-12-03 11:17:50', N'1', N'2021-12-03 11:17:50', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (134, N'閫€娆捐鍗曠姸鎬?, N'pay_refund_status', 0, N'閫€娆捐鍗曠姸鎬?, N'1', N'2021-12-10 16:42:50', N'1', N'2023-07-19 10:13:17', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (139, N'娴佺▼瀹炰緥鐨勭姸鎬?, N'bpm_process_instance_status', 0, N'娴佺▼瀹炰緥鐨勭姸鎬?, N'1', N'2022-01-07 23:46:42', N'1', N'2022-01-07 23:46:42', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (140, N'娴佺▼瀹炰緥鐨勭粨鏋?, N'bpm_task_status', 0, N'娴佺▼瀹炰緥鐨勭粨鏋?, N'1', N'2022-01-07 23:48:10', N'1', N'2024-03-08 22:42:03', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (141, N'娴佺▼鐨勮〃鍗曠被鍨?, N'bpm_model_form_type', 0, N'娴佺▼鐨勮〃鍗曠被鍨?, N'103', N'2022-01-11 23:50:45', N'103', N'2022-01-11 23:50:45', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (142, N'浠诲姟鍒嗛厤瑙勫垯鐨勭被鍨?, N'bpm_task_candidate_strategy', 0, N'BPM 浠诲姟鐨勫€欓€変汉鐨勭瓥鐣?, N'103', N'2022-01-12 23:21:04', N'103', N'2024-03-06 02:53:59', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (144, N'浠ｇ爜鐢熸垚鐨勫満鏅灇涓?, N'infra_codegen_scene', 0, N'浠ｇ爜鐢熸垚鐨勫満鏅灇涓?, N'1', N'2022-02-02 13:14:45', N'1', N'2022-03-10 16:33:46', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (145, N'瑙掕壊绫诲瀷', N'system_role_type', 0, N'瑙掕壊绫诲瀷', N'1', N'2022-02-16 13:01:46', N'1', N'2022-02-16 13:01:46', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (146, N'鏂囦欢瀛樺偍鍣?, N'infra_file_storage', 0, N'鏂囦欢瀛樺偍鍣?, N'1', N'2022-03-15 00:24:38', N'1', N'2022-03-15 00:24:38', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (147, N'OAuth 2.0 鎺堟潈绫诲瀷', N'system_oauth2_grant_type', 0, N'OAuth 2.0 鎺堟潈绫诲瀷锛堟ā寮忥級', N'1', N'2022-05-12 00:20:52', N'1', N'2022-05-11 16:25:49', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (149, N'鍟嗗搧 SPU 鐘舵€?, N'product_spu_status', 0, N'鍟嗗搧 SPU 鐘舵€?, N'1', N'2022-10-24 21:19:04', N'1', N'2022-10-24 21:19:08', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (150, N'浼樻儬绫诲瀷', N'promotion_discount_type', 0, N'浼樻儬绫诲瀷', N'1', N'2022-11-01 12:46:06', N'1', N'2022-11-01 12:46:06', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (151, N'浼樻儬鍔垫ā鏉跨殑鏈夐檺鏈熺被鍨?, N'promotion_coupon_template_validity_type', 0, N'浼樻儬鍔垫ā鏉跨殑鏈夐檺鏈熺被鍨?, N'1', N'2022-11-02 00:06:20', N'1', N'2022-11-04 00:08:26', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (152, N'钀ラ攢鐨勫晢鍝佽寖鍥?, N'promotion_product_scope', 0, N'钀ラ攢鐨勫晢鍝佽寖鍥?, N'1', N'2022-11-02 00:28:01', N'1', N'2022-11-02 00:28:01', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (153, N'浼樻儬鍔电殑鐘舵€?, N'promotion_coupon_status', 0, N'浼樻儬鍔电殑鐘舵€?, N'1', N'2022-11-04 00:14:49', N'1', N'2022-11-04 00:14:49', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (154, N'浼樻儬鍔电殑棰嗗彇鏂瑰紡', N'promotion_coupon_take_type', 0, N'浼樻儬鍔电殑棰嗗彇鏂瑰紡', N'1', N'2022-11-04 19:12:27', N'1', N'2022-11-04 19:12:27', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (155, N'淇冮攢娲诲姩鐨勭姸鎬?, N'promotion_activity_status', 0, N'淇冮攢娲诲姩鐨勭姸鎬?, N'1', N'2022-11-04 22:54:23', N'1', N'2022-11-04 22:54:23', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (156, N'钀ラ攢鐨勬潯浠剁被鍨?, N'promotion_condition_type', 0, N'钀ラ攢鐨勬潯浠剁被鍨?, N'1', N'2022-11-04 22:59:23', N'1', N'2022-11-04 22:59:23', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (157, N'浜ゆ槗鍞悗鐘舵€?, N'trade_after_sale_status', 0, N'浜ゆ槗鍞悗鐘舵€?, N'1', N'2022-11-19 20:52:56', N'1', N'2022-11-19 20:52:56', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (158, N'浜ゆ槗鍞悗鐨勭被鍨?, N'trade_after_sale_type', 0, N'浜ゆ槗鍞悗鐨勭被鍨?, N'1', N'2022-11-19 21:04:09', N'1', N'2022-11-19 21:04:09', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (159, N'浜ゆ槗鍞悗鐨勬柟寮?, N'trade_after_sale_way', 0, N'浜ゆ槗鍞悗鐨勬柟寮?, N'1', N'2022-11-19 21:39:04', N'1', N'2022-11-19 21:39:04', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (160, N'缁堢', N'terminal', 0, N'缁堢', N'1', N'2022-12-10 10:50:50', N'1', N'2022-12-10 10:53:11', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (161, N'浜ゆ槗璁㈠崟鐨勭被鍨?, N'trade_order_type', 0, N'浜ゆ槗璁㈠崟鐨勭被鍨?, N'1', N'2022-12-10 16:33:54', N'1', N'2022-12-10 16:33:54', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (162, N'浜ゆ槗璁㈠崟鐨勭姸鎬?, N'trade_order_status', 0, N'浜ゆ槗璁㈠崟鐨勭姸鎬?, N'1', N'2022-12-10 16:48:44', N'1', N'2022-12-10 16:48:44', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (163, N'浜ゆ槗璁㈠崟椤圭殑鍞悗鐘舵€?, N'trade_order_item_after_sale_status', 0, N'浜ゆ槗璁㈠崟椤圭殑鍞悗鐘舵€?, N'1', N'2022-12-10 20:58:08', N'1', N'2022-12-10 20:58:08', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (164, N'鍏紬鍙疯嚜鍔ㄥ洖澶嶇殑璇锋眰鍏抽敭瀛楀尮閰嶆ā寮?, N'mp_auto_reply_request_match', 0, N'鍏紬鍙疯嚜鍔ㄥ洖澶嶇殑璇锋眰鍏抽敭瀛楀尮閰嶆ā寮?, N'1', N'2023-01-16 23:29:56', N'1', N'2023-01-16 23:29:56', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (165, N'鍏紬鍙风殑娑堟伅绫诲瀷', N'mp_message_type', 0, N'鍏紬鍙风殑娑堟伅绫诲瀷', N'1', N'2023-01-17 22:17:09', N'1', N'2023-01-17 22:17:09', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (166, N'閭欢鍙戦€佺姸鎬?, N'system_mail_send_status', 0, N'閭欢鍙戦€佺姸鎬?, N'1', N'2023-01-26 09:53:13', N'1', N'2023-01-26 09:53:13', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (167, N'绔欏唴淇℃ā鐗堢殑绫诲瀷', N'system_notify_template_type', 0, N'绔欏唴淇℃ā鐗堢殑绫诲瀷', N'1', N'2023-01-28 10:35:10', N'1', N'2023-01-28 10:35:10', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (168, N'浠ｇ爜鐢熸垚鐨勫墠绔被鍨?, N'infra_codegen_front_type', 0, N'', N'1', N'2023-04-12 23:57:52', N'1', N'2023-04-12 23:57:52', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (170, N'蹇€掕璐规柟寮?, N'trade_delivery_express_charge_mode', 0, N'鐢ㄤ簬鍟嗗煄浜ゆ槗妯″潡閰嶉€佺鐞?, N'1', N'2023-05-21 22:45:03', N'1', N'2023-05-21 22:45:03', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (171, N'绉垎涓氬姟绫诲瀷', N'member_point_biz_type', 0, N'', N'1', N'2023-06-10 12:15:00', N'1', N'2023-06-28 13:48:20', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (173, N'鏀粯閫氱煡绫诲瀷', N'pay_notify_type', 0, NULL, N'1', N'2023-07-20 12:23:03', N'1', N'2023-07-20 12:23:03', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (174, N'浼氬憳缁忛獙涓氬姟绫诲瀷', N'member_experience_biz_type', 0, NULL, N'', N'2023-08-22 12:41:01', N'', N'2023-08-22 12:41:01', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (175, N'浜ゆ槗閰嶉€佺被鍨?, N'trade_delivery_type', 0, N'', N'1', N'2023-08-23 00:03:14', N'1', N'2023-08-23 00:03:14', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (176, N'鍒嗕剑妯″紡', N'brokerage_enabled_condition', 0, NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (177, N'鍒嗛攢鍏崇郴缁戝畾妯″紡', N'brokerage_bind_mode', 0, NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (178, N'浣ｉ噾鎻愮幇绫诲瀷', N'brokerage_withdraw_type', 0, NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (179, N'浣ｉ噾璁板綍涓氬姟绫诲瀷', N'brokerage_record_biz_type', 0, NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (180, N'浣ｉ噾璁板綍鐘舵€?, N'brokerage_record_status', 0, NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (181, N'浣ｉ噾鎻愮幇鐘舵€?, N'brokerage_withdraw_status', 0, NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (182, N'浣ｉ噾鎻愮幇閾惰', N'brokerage_bank_name', 0, NULL, N'', N'2023-09-28 02:46:05', N'', N'2023-09-28 02:46:05', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (183, N'鐮嶄环璁板綍鐨勭姸鎬?, N'promotion_bargain_record_status', 0, N'', N'1', N'2023-10-05 10:41:08', N'1', N'2023-10-05 10:41:08', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (184, N'鎷煎洟璁板綍鐨勭姸鎬?, N'promotion_combination_record_status', 0, N'', N'1', N'2023-10-08 07:24:25', N'1', N'2023-10-08 07:24:25', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (185, N'鍥炴-鍥炴鏂瑰紡', N'crm_receivable_return_type', 0, N'鍥炴-鍥炴鏂瑰紡', N'1', N'2023-10-18 21:54:10', N'1', N'2023-10-18 21:54:10', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (186, N'CRM 瀹㈡埛琛屼笟', N'crm_customer_industry', 0, N'CRM 瀹㈡埛鎵€灞炶涓?, N'1', N'2023-10-28 22:57:07', N'1', N'2024-02-18 23:30:22', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (187, N'瀹㈡埛绛夌骇', N'crm_customer_level', 0, N'CRM 瀹㈡埛绛夌骇', N'1', N'2023-10-28 22:59:12', N'1', N'2023-10-28 15:11:16', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (188, N'瀹㈡埛鏉ユ簮', N'crm_customer_source', 0, N'CRM 瀹㈡埛鏉ユ簮', N'1', N'2023-10-28 23:00:34', N'1', N'2023-10-28 15:11:16', N'0', NULL)
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (600, N'Banner 浣嶇疆', N'promotion_banner_position', 0, N'', N'1', N'2023-10-08 07:24:25', N'1', N'2023-11-04 13:04:02', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (601, N'绀句氦绫诲瀷', N'system_social_type', 0, N'', N'1', N'2023-11-04 13:03:54', N'1', N'2023-11-04 13:03:54', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (604, N'浜у搧鐘舵€?, N'crm_product_status', 0, N'', N'1', N'2023-10-30 21:47:59', N'1', N'2023-10-30 21:48:45', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (605, N'CRM 鏁版嵁鏉冮檺鐨勭骇鍒?, N'crm_permission_level', 0, N'', N'1', N'2023-11-30 09:51:59', N'1', N'2023-11-30 09:51:59', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (606, N'CRM 瀹℃壒鐘舵€?, N'crm_audit_status', 0, N'', N'1', N'2023-11-30 18:56:23', N'1', N'2023-11-30 18:56:23', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (607, N'CRM 浜у搧鍗曚綅', N'crm_product_unit', 0, N'', N'1', N'2023-12-05 23:01:51', N'1', N'2023-12-05 23:01:51', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (608, N'CRM 璺熻繘鏂瑰紡', N'crm_follow_up_type', 0, N'', N'1', N'2024-01-15 20:48:05', N'1', N'2024-01-15 20:48:05', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (610, N'杞处璁㈠崟鐘舵€?, N'pay_transfer_status', 0, N'', N'1', N'2023-10-28 16:18:32', N'1', N'2023-10-28 16:18:32', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (611, N'ERP 搴撳瓨鏄庣粏鐨勪笟鍔＄被鍨?, N'erp_stock_record_biz_type', 0, N'ERP 搴撳瓨鏄庣粏鐨勪笟鍔＄被鍨?, N'1', N'2024-02-05 18:07:02', N'1', N'2024-02-05 18:07:02', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (612, N'ERP 瀹℃壒鐘舵€?, N'erp_audit_status', 0, N'', N'1', N'2024-02-06 00:00:07', N'1', N'2024-02-06 00:00:07', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (613, N'BPM 鐩戝惉鍣ㄧ被鍨?, N'bpm_process_listener_type', 0, N'', N'1', N'2024-03-23 12:52:24', N'1', N'2024-03-09 15:54:28', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (615, N'BPM 鐩戝惉鍣ㄥ€肩被鍨?, N'bpm_process_listener_value_type', 0, N'', N'1', N'2024-03-23 13:00:31', N'1', N'2024-03-23 13:00:31', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (616, N'鏃堕棿闂撮殧', N'date_interval', 0, N'', N'1', N'2024-03-29 22:50:09', N'1', N'2024-03-29 22:50:09', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (619, N'CRM 鍟嗘満缁撴潫鐘舵€佺被鍨?, N'crm_business_end_status_type', 0, N'', N'1', N'2024-04-13 23:23:00', N'1', N'2024-04-13 23:23:00', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (620, N'AI 妯″瀷骞冲彴', N'ai_platform', 0, N'', N'1', N'2024-05-09 22:27:38', N'1', N'2024-05-09 22:27:38', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (621, N'AI 缁樼敾鐘舵€?, N'ai_image_status', 0, N'', N'1', N'2024-06-26 20:51:23', N'1', N'2024-06-26 20:51:23', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (622, N'AI 闊充箰鐘舵€?, N'ai_music_status', 0, N'', N'1', N'2024-06-27 22:45:07', N'1', N'2024-06-28 00:56:27', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (623, N'AI 闊充箰鐢熸垚妯″紡', N'ai_generate_mode', 0, N'', N'1', N'2024-06-27 22:46:21', N'1', N'2024-06-28 01:22:29', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (624, N'鍐欎綔璇皵', N'ai_write_tone', 0, N'', N'1', N'2024-07-07 15:19:02', N'1', N'2024-07-07 15:19:02', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (625, N'鍐欎綔璇█', N'ai_write_language', 0, N'', N'1', N'2024-07-07 15:18:52', N'1', N'2024-07-07 15:18:52', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (626, N'鍐欎綔闀垮害', N'ai_write_length', 0, N'', N'1', N'2024-07-07 15:18:41', N'1', N'2024-07-07 15:18:41', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (627, N'鍐欎綔鏍煎紡', N'ai_write_format', 0, N'', N'1', N'2024-07-07 15:14:34', N'1', N'2024-07-07 15:14:34', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (628, N'AI 鍐欎綔绫诲瀷', N'ai_write_type', 0, N'', N'1', N'2024-07-10 21:25:29', N'1', N'2024-07-10 21:25:29', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (629, N'BPM 娴佺▼妯″瀷绫诲瀷', N'bpm_model_type', 0, N'', N'1', N'2024-08-26 15:21:43', N'1', N'2024-08-26 15:21:43', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (640, N'AI 妯″瀷绫诲瀷', N'ai_model_type', 0, N'', N'1', N'2025-03-03 12:24:07', N'1', N'2025-03-03 12:24:07', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1000, N'IoT 鏁版嵁鏍煎紡', N'iot_data_format', 0, N'', N'1', N'2024-08-10 11:52:58', N'1', N'2025-03-17 09:25:06', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1001, N'IoT 浜у搧璁惧绫诲瀷', N'iot_product_device_type', 0, N'', N'1', N'2024-08-10 11:54:30', N'1', N'2025-03-17 09:25:08', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1002, N'IoT 浜у搧鐘舵€?, N'iot_product_status', 0, N'', N'1', N'2024-08-10 12:06:09', N'1', N'2025-03-17 09:25:10', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1003, N'IoT 鏁版嵁鏍￠獙绾у埆', N'iot_validate_type', 0, N'', N'1', N'2024-09-06 20:05:13', N'1', N'2025-03-17 09:25:12', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1004, N'IoT 鑱旂綉鏂瑰紡', N'iot_net_type', 0, N'', N'1', N'2024-09-06 22:04:13', N'1', N'2025-03-17 09:25:14', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1005, N'IoT 鎺ュ叆缃戝叧鍗忚', N'iot_protocol_type', 0, N'', N'1', N'2024-09-06 22:20:17', N'1', N'2025-03-17 09:25:16', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1006, N'IoT 璁惧鐘舵€?, N'iot_device_state', 0, N'', N'1', N'2024-09-21 08:12:55', N'1', N'2025-03-17 09:25:19', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1007, N'IoT 鐗╂ā鍨嬪姛鑳界被鍨?, N'iot_thing_model_type', 0, N'', N'1', N'2024-09-29 20:02:36', N'1', N'2025-03-17 09:25:24', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1008, N'IoT 鎻掍欢閮ㄧ讲鏂瑰紡', N'iot_plugin_deploy_type', 0, N'', N'1', N'2024-12-13 10:55:13', N'1', N'2025-03-17 09:25:27', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1009, N'IoT 鎻掍欢鐘舵€?, N'iot_plugin_status', 0, N'', N'1', N'2024-12-13 11:05:34', N'1', N'2025-03-17 09:25:30', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1010, N'IoT 鎻掍欢绫诲瀷', N'iot_plugin_type', 0, N'', N'1', N'2024-12-13 11:08:19', N'1', N'2025-03-17 09:25:32', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1011, N'IoT 鐗╂ā鍨嬪崟浣?, N'iot_thing_model_unit', 0, N'', N'1', N'2024-12-25 17:36:46', N'1', N'2025-03-17 09:25:35', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1012, N'IoT 鏁版嵁妗ユ帴鐨勬柟鍚戞灇涓?, N'iot_data_bridge_direction_enum', 0, N'', N'1', N'2025-03-09 12:37:40', N'1', N'2025-03-17 09:25:39', N'0', N'1970-01-01 00:00:00')
GO
INSERT INTO system_dict_type (id, name, type, status, remark, creator, create_time, updater, update_time, deleted, deleted_time) VALUES (1013, N'IoT 鏁版嵁妗ユ鐨勭被鍨嬫灇涓?, N'iot_data_bridge_type_enum', 0, N'', N'1', N'2025-03-09 12:39:36', N'1', N'2025-04-06 17:09:46', N'0', N'1970-01-01 00:00:00')
GO
SET IDENTITY_INSERT system_dict_type OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_login_log
-- ----------------------------
DROP TABLE IF EXISTS system_login_log
GO
CREATE TABLE system_login_log
(
    id          bigint                                 NOT NULL PRIMARY KEY IDENTITY,
    log_type    bigint                                 NOT NULL,
    trace_id    nvarchar(64) DEFAULT ''                NOT NULL,
    user_id     bigint       DEFAULT 0                 NOT NULL,
    user_type   tinyint      DEFAULT 0                 NOT NULL,
    username    nvarchar(50) DEFAULT ''                NOT NULL,
    result      tinyint                                NOT NULL,
    user_ip     nvarchar(50)                           NOT NULL,
    user_agent  nvarchar(512)                          NOT NULL,
    creator     nvarchar(64) DEFAULT ''                NULL,
    create_time datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64) DEFAULT ''                NULL,
    update_time datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit          DEFAULT 0                 NOT NULL,
    tenant_id   bigint       DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璁块棶ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏃ュ織绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'log_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閾捐矾杩借釜缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'trace_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛璐﹀彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'username'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐧婚檰缁撴灉',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'result'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛 IP',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'user_ip'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'娴忚鍣?UA',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'user_agent'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绯荤粺璁块棶璁板綍',
     'SCHEMA', N'dbo',
     'TABLE', N'system_login_log'
GO

-- ----------------------------
-- Table structure for system_mail_account
-- ----------------------------
DROP TABLE IF EXISTS system_mail_account
GO
CREATE TABLE system_mail_account
(
    id              bigint                                 NOT NULL PRIMARY KEY IDENTITY,
    mail            nvarchar(255)                          NOT NULL,
    username        nvarchar(255)                          NOT NULL,
    password        nvarchar(255)                          NOT NULL,
    host            nvarchar(255)                          NOT NULL,
    port            int                                    NOT NULL,
    ssl_enable      varchar(1)   DEFAULT '0'               NOT NULL,
    starttls_enable varchar(1)   DEFAULT '0'               NOT NULL,
    creator         nvarchar(64) DEFAULT ''                NULL,
    create_time     datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater         nvarchar(64) DEFAULT ''                NULL,
    update_time     datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted         bit          DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'涓婚敭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account',
     'COLUMN', N'mail'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account',
     'COLUMN', N'username'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀵嗙爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account',
     'COLUMN', N'password'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'SMTP 鏈嶅姟鍣ㄥ煙鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account',
     'COLUMN', N'host'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'SMTP 鏈嶅姟鍣ㄧ鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account',
     'COLUMN', N'port'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁寮€鍚?SSL',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account',
     'COLUMN', N'ssl_enable'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁寮€鍚?STARTTLS',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account',
     'COLUMN', N'starttls_enable'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閭璐﹀彿琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_account'
GO

-- ----------------------------
-- Records of system_mail_account
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_mail_account ON
GO
INSERT INTO system_mail_account (id, mail, username, password, host, port, ssl_enable, starttls_enable, creator, create_time, updater, update_time, deleted) VALUES (1, N'7684413@qq.com', N'7684413@qq.com', N'1234576', N'127.0.0.1', 8080, N'0', N'0', N'1', N'2023-01-25 17:39:52', N'1', N'2025-04-04 16:34:40', N'0')
GO
INSERT INTO system_mail_account (id, mail, username, password, host, port, ssl_enable, starttls_enable, creator, create_time, updater, update_time, deleted) VALUES (2, N'ydym_test@163.com', N'ydym_test@163.com', N'WBZTEINMIFVRYSOE', N'smtp.163.com', 465, N'1', N'0', N'1', N'2023-01-26 01:26:03', N'1', N'2023-04-12 22:39:38', N'0')
GO
INSERT INTO system_mail_account (id, mail, username, password, host, port, ssl_enable, starttls_enable, creator, create_time, updater, update_time, deleted) VALUES (3, N'76854114@qq.com', N'3335', N'11234', N'yunai1.cn', 466, N'0', N'0', N'1', N'2023-01-27 15:06:38', N'1', N'2023-01-27 07:08:36', N'1')
GO
INSERT INTO system_mail_account (id, mail, username, password, host, port, ssl_enable, starttls_enable, creator, create_time, updater, update_time, deleted) VALUES (4, N'7685413x@qq.com', N'2', N'3', N'4', 5, N'1', N'0', N'1', N'2023-04-12 23:05:06', N'1', N'2023-04-12 15:05:11', N'1')
GO
SET IDENTITY_INSERT system_mail_account OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_mail_log
-- ----------------------------
DROP TABLE IF EXISTS system_mail_log
GO
CREATE TABLE system_mail_log
(
    id                bigint                                   NOT NULL PRIMARY KEY IDENTITY,
    user_id           bigint         DEFAULT NULL              NULL,
    user_type         tinyint        DEFAULT NULL              NULL,
    to_mail           nvarchar(255)                            NOT NULL,
    account_id        bigint                                   NOT NULL,
    from_mail         nvarchar(255)                            NOT NULL,
    template_id       bigint                                   NOT NULL,
    template_code     nvarchar(63)                             NOT NULL,
    template_nickname nvarchar(255)  DEFAULT NULL              NULL,
    template_title    nvarchar(255)                            NOT NULL,
    template_content  nvarchar(4000)                           NOT NULL,
    template_params   nvarchar(255)                            NOT NULL,
    send_status       tinyint        DEFAULT 0                 NOT NULL,
    send_time         datetime2      DEFAULT NULL              NULL,
    send_message_id   nvarchar(255)  DEFAULT NULL              NULL,
    send_exception    nvarchar(4000) DEFAULT NULL              NULL,
    creator           nvarchar(64)   DEFAULT ''                NULL,
    create_time       datetime2      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater           nvarchar(64)   DEFAULT ''                NULL,
    update_time       datetime2      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted           bit            DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎺ユ敹閭鍦板潃',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'to_mail'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閭璐﹀彿缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'account_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙戦€侀偖绠卞湴鍧€',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'from_mail'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'template_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘缂栫爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'template_code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯＄増鍙戦€佷汉鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'template_nickname'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閭欢鏍囬',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'template_title'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閭欢鍐呭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'template_content'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閭欢鍙傛暟',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'template_params'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙戦€佺姸鎬?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'send_status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙戦€佹椂闂?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'send_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙戦€佽繑鍥炵殑娑堟伅 ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'send_message_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙戦€佸紓甯?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'send_exception'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閭欢鏃ュ織琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_log'
GO

-- ----------------------------
-- Table structure for system_mail_template
-- ----------------------------
DROP TABLE IF EXISTS system_mail_template
GO
CREATE TABLE system_mail_template
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name        nvarchar(63)                            NOT NULL,
    code        nvarchar(63)                            NOT NULL,
    account_id  bigint                                  NOT NULL,
    nickname    nvarchar(255) DEFAULT NULL              NULL,
    title       nvarchar(255)                           NOT NULL,
    content     nvarchar(4000)                          NOT NULL,
    params      nvarchar(255)                           NOT NULL,
    status      tinyint                                 NOT NULL,
    remark      nvarchar(255) DEFAULT NULL              NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘缂栫爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙戦€佺殑閭璐﹀彿缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'account_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙戦€佷汉鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'nickname'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘鏍囬',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'title'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘鍐呭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'content'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙傛暟鏁扮粍',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'params'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮€鍚姸鎬?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶囨敞',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閭欢妯＄増琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_mail_template'
GO

-- ----------------------------
-- Records of system_mail_template
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_mail_template ON
GO
INSERT INTO system_mail_template (id, name, code, account_id, nickname, title, content, params, status, remark, creator, create_time, updater, update_time, deleted) VALUES (13, N'鍚庡彴鐢ㄦ埛鐭俊鐧诲綍', N'admin-sms-login', 1, N'濂ョ壒鏇?, N'浣犵寽鎴戠寽', N'<p>鎮ㄧ殑楠岃瘉鐮佹槸{code}锛屽悕瀛楁槸{name}</p>', N'["code","name"]', 0, N'3', N'1', N'2021-10-11 08:10:00', N'1', N'2023-12-02 19:51:14', N'0')
GO
INSERT INTO system_mail_template (id, name, code, account_id, nickname, title, content, params, status, remark, creator, create_time, updater, update_time, deleted) VALUES (14, N'娴嬭瘯妯＄増', N'test_01', 2, N'鑺嬭壙', N'涓€涓爣棰?, N'<p>浣犳槸 {key01} 鍚楋紵</p><p><br></p><p>鏄殑璇濓紝璧剁揣 {key02} 涓€涓嬶紒</p>', N'["key01","key02"]', 0, NULL, N'1', N'2023-01-26 01:27:40', N'1', N'2023-01-27 10:32:16', N'0')
GO
INSERT INTO system_mail_template (id, name, code, account_id, nickname, title, content, params, status, remark, creator, create_time, updater, update_time, deleted) VALUES (15, N'3', N'2', 2, N'7', N'4', N'<p>45</p>', N'[]', 1, N'80', N'1', N'2023-01-27 15:50:35', N'1', N'2023-01-27 16:34:49', N'0')
GO
SET IDENTITY_INSERT system_mail_template OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_menu
-- ----------------------------
DROP TABLE IF EXISTS system_menu
GO
CREATE TABLE system_menu
(
    id             bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name           nvarchar(50)                            NOT NULL,
    permission     nvarchar(100) DEFAULT ''                NOT NULL,
    type           tinyint                                 NOT NULL,
    sort           int           DEFAULT 0                 NOT NULL,
    parent_id      bigint        DEFAULT 0                 NOT NULL,
    path           nvarchar(200) DEFAULT ''                NULL,
    icon           nvarchar(100) DEFAULT '#'               NULL,
    component      nvarchar(255) DEFAULT NULL              NULL,
    component_name nvarchar(255) DEFAULT NULL              NULL,
    status         tinyint       DEFAULT 0                 NOT NULL,
    visible        varchar(1)    DEFAULT '1'               NOT NULL,
    keep_alive     varchar(1)    DEFAULT '1'               NOT NULL,
    always_show    varchar(1)    DEFAULT '1'               NOT NULL,
    creator        nvarchar(64)  DEFAULT ''                NULL,
    create_time    datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater        nvarchar(64)  DEFAULT ''                NULL,
    update_time    datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted        bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑿滃崟ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑿滃崟鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏉冮檺鏍囪瘑',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'permission'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑿滃崟绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄剧ず椤哄簭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'sort'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐖惰彍鍗旾D',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'parent_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璺敱鍦板潃',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'path'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑿滃崟鍥炬爣',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'icon'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缁勪欢璺緞',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'component'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缁勪欢鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'component_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑿滃崟鐘舵€?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍙',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'visible'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁缂撳瓨',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'keep_alive'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鎬绘槸鏄剧ず',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'always_show'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑿滃崟鏉冮檺琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_menu'
GO

-- ----------------------------
-- Records of system_menu
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_menu ON
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1, N'绯荤粺绠＄悊', N'', 1, 10, 0, N'/system', N'ep:tools', NULL, NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2025-03-15 21:30:27', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2, N'鍩虹璁炬柦', N'', 1, 20, 0, N'/infra', N'ep:monitor', NULL, NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-03-01 08:28:40', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (5, N'OA 绀轰緥', N'', 1, 40, 1185, N'oa', N'fa:road', NULL, NULL, 0, N'1', N'1', N'1', N'admin', N'2021-09-20 16:26:19', N'1', N'2024-02-29 12:38:13', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (100, N'鐢ㄦ埛绠＄悊', N'system:user:list', 2, 1, 1, N'user', N'ep:avatar', N'system/user/index', N'SystemUser', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2025-03-15 21:30:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (101, N'瑙掕壊绠＄悊', N'', 2, 2, 1, N'role', N'ep:user', N'system/role/index', N'SystemRole', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-05-01 18:35:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (102, N'鑿滃崟绠＄悊', N'', 2, 3, 1, N'menu', N'ep:menu', N'system/menu/index', N'SystemMenu', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:03:50', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (103, N'閮ㄩ棬绠＄悊', N'', 2, 4, 1, N'dept', N'fa:address-card', N'system/dept/index', N'SystemDept', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:06:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (104, N'宀椾綅绠＄悊', N'', 2, 5, 1, N'post', N'fa:address-book-o', N'system/post/index', N'SystemPost', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:06:39', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (105, N'瀛楀吀绠＄悊', N'', 2, 6, 1, N'dict', N'ep:collection', N'system/dict/index', N'SystemDictType', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:07:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (106, N'閰嶇疆绠＄悊', N'', 2, 8, 2, N'config', N'fa:connectdevelop', N'infra/config/index', N'InfraConfig', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-04-23 00:02:45', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (107, N'閫氱煡鍏憡', N'', 2, 4, 2739, N'notice', N'ep:takeaway-box', N'system/notice/index', N'SystemNotice', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-04-22 23:56:17', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (108, N'瀹¤鏃ュ織', N'', 1, 9, 1, N'log', N'ep:document-copy', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:08:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (109, N'浠ょ墝绠＄悊', N'', 2, 2, 1261, N'token', N'fa:key', N'system/oauth2/token/index', N'SystemTokenClient', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:13:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (110, N'瀹氭椂浠诲姟', N'', 2, 7, 2, N'job', N'fa-solid:tasks', N'infra/job/index', N'InfraJob', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 08:57:36', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (111, N'MySQL 鐩戞帶', N'', 2, 1, 2740, N'druid', N'fa-solid:box', N'infra/druid/index', N'InfraDruid', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-04-23 00:05:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (112, N'Java 鐩戞帶', N'', 2, 3, 2740, N'admin-server', N'ep:coffee-cup', N'infra/server/index', N'InfraAdminServer', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-04-23 00:06:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (113, N'Redis 鐩戞帶', N'', 2, 2, 2740, N'redis', N'fa:reddit-square', N'infra/redis/index', N'InfraRedis', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-04-23 00:06:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (114, N'琛ㄥ崟鏋勫缓', N'infra:build:list', 2, 2, 2, N'build', N'fa:wpforms', N'infra/build/index', N'InfraBuild', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 08:51:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (115, N'浠ｇ爜鐢熸垚', N'infra:codegen:query', 2, 1, 2, N'codegen', N'ep:document-copy', N'infra/codegen/index', N'InfraCodegen', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 08:51:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (116, N'API 鎺ュ彛', N'infra:swagger:list', 2, 3, 2, N'swagger', N'fa:fighter-jet', N'infra/swagger/index', N'InfraSwagger', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-04-23 00:01:24', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (500, N'鎿嶄綔鏃ュ織', N'', 2, 1, 108, N'operate-log', N'ep:position', N'system/operatelog/index', N'SystemOperateLog', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:09:59', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (501, N'鐧诲綍鏃ュ織', N'', 2, 2, 108, N'login-log', N'ep:promotion', N'system/loginlog/index', N'SystemLoginLog', 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2024-02-29 01:10:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1001, N'鐢ㄦ埛鏌ヨ', N'system:user:query', 3, 1, 100, N'', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1002, N'鐢ㄦ埛鏂板', N'system:user:create', 3, 2, 100, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1003, N'鐢ㄦ埛淇敼', N'system:user:update', 3, 3, 100, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1004, N'鐢ㄦ埛鍒犻櫎', N'system:user:delete', 3, 4, 100, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1005, N'鐢ㄦ埛瀵煎嚭', N'system:user:export', 3, 5, 100, N'', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1006, N'鐢ㄦ埛瀵煎叆', N'system:user:import', 3, 6, 100, N'', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1007, N'閲嶇疆瀵嗙爜', N'system:user:update-password', 3, 7, 100, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1008, N'瑙掕壊鏌ヨ', N'system:role:query', 3, 1, 101, N'', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1009, N'瑙掕壊鏂板', N'system:role:create', 3, 2, 101, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1010, N'瑙掕壊淇敼', N'system:role:update', 3, 3, 101, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1011, N'瑙掕壊鍒犻櫎', N'system:role:delete', 3, 4, 101, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1012, N'瑙掕壊瀵煎嚭', N'system:role:export', 3, 5, 101, N'', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1013, N'鑿滃崟鏌ヨ', N'system:menu:query', 3, 1, 102, N'', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1014, N'鑿滃崟鏂板', N'system:menu:create', 3, 2, 102, N'', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1015, N'鑿滃崟淇敼', N'system:menu:update', 3, 3, 102, N'', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1016, N'鑿滃崟鍒犻櫎', N'system:menu:delete', 3, 4, 102, N'', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1017, N'閮ㄩ棬鏌ヨ', N'system:dept:query', 3, 1, 103, N'', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1018, N'閮ㄩ棬鏂板', N'system:dept:create', 3, 2, 103, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1019, N'閮ㄩ棬淇敼', N'system:dept:update', 3, 3, 103, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1020, N'閮ㄩ棬鍒犻櫎', N'system:dept:delete', 3, 4, 103, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1021, N'宀椾綅鏌ヨ', N'system:post:query', 3, 1, 104, N'', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1022, N'宀椾綅鏂板', N'system:post:create', 3, 2, 104, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1023, N'宀椾綅淇敼', N'system:post:update', 3, 3, 104, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1024, N'宀椾綅鍒犻櫎', N'system:post:delete', 3, 4, 104, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1025, N'宀椾綅瀵煎嚭', N'system:post:export', 3, 5, 104, N'', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1026, N'瀛楀吀鏌ヨ', N'system:dict:query', 3, 1, 105, N'#', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1027, N'瀛楀吀鏂板', N'system:dict:create', 3, 2, 105, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1028, N'瀛楀吀淇敼', N'system:dict:update', 3, 3, 105, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1029, N'瀛楀吀鍒犻櫎', N'system:dict:delete', 3, 4, 105, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1030, N'瀛楀吀瀵煎嚭', N'system:dict:export', 3, 5, 105, N'#', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1031, N'閰嶇疆鏌ヨ', N'infra:config:query', 3, 1, 106, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1032, N'閰嶇疆鏂板', N'infra:config:create', 3, 2, 106, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1033, N'閰嶇疆淇敼', N'infra:config:update', 3, 3, 106, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1034, N'閰嶇疆鍒犻櫎', N'infra:config:delete', 3, 4, 106, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1035, N'閰嶇疆瀵煎嚭', N'infra:config:export', 3, 5, 106, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1036, N'鍏憡鏌ヨ', N'system:notice:query', 3, 1, 107, N'#', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1037, N'鍏憡鏂板', N'system:notice:create', 3, 2, 107, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1038, N'鍏憡淇敼', N'system:notice:update', 3, 3, 107, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1039, N'鍏憡鍒犻櫎', N'system:notice:delete', 3, 4, 107, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1040, N'鎿嶄綔鏌ヨ', N'system:operate-log:query', 3, 1, 500, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1042, N'鏃ュ織瀵煎嚭', N'system:operate-log:export', 3, 2, 500, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1043, N'鐧诲綍鏌ヨ', N'system:login-log:query', 3, 1, 501, N'#', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1045, N'鏃ュ織瀵煎嚭', N'system:login-log:export', 3, 3, 501, N'#', N'#', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1046, N'浠ょ墝鍒楄〃', N'system:oauth2-token:page', 3, 1, 109, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-05-09 23:54:42', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1048, N'浠ょ墝鍒犻櫎', N'system:oauth2-token:delete', 3, 2, 109, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-05-09 23:54:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1050, N'浠诲姟鏂板', N'infra:job:create', 3, 2, 110, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1051, N'浠诲姟淇敼', N'infra:job:update', 3, 3, 110, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1052, N'浠诲姟鍒犻櫎', N'infra:job:delete', 3, 4, 110, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1053, N'鐘舵€佷慨鏀?, N'infra:job:update', 3, 5, 110, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1054, N'浠诲姟瀵煎嚭', N'infra:job:export', 3, 7, 110, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1056, N'鐢熸垚淇敼', N'infra:codegen:update', 3, 2, 115, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1057, N'鐢熸垚鍒犻櫎', N'infra:codegen:delete', 3, 3, 115, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1058, N'瀵煎叆浠ｇ爜', N'infra:codegen:create', 3, 2, 115, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1059, N'棰勮浠ｇ爜', N'infra:codegen:preview', 3, 4, 115, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1060, N'鐢熸垚浠ｇ爜', N'infra:codegen:download', 3, 5, 115, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'admin', N'2021-01-05 17:03:48', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1063, N'璁剧疆瑙掕壊鑿滃崟鏉冮檺', N'system:permission:assign-role-menu', 3, 6, 101, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-01-06 17:53:44', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1064, N'璁剧疆瑙掕壊鏁版嵁鏉冮檺', N'system:permission:assign-role-data-scope', 3, 7, 101, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-01-06 17:56:31', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1065, N'璁剧疆鐢ㄦ埛瑙掕壊', N'system:permission:assign-user-role', 3, 8, 101, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-01-07 10:23:28', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1066, N'鑾峰緱 Redis 鐩戞帶淇℃伅', N'infra:redis:get-monitor-info', 3, 1, 113, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-01-26 01:02:31', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1067, N'鑾峰緱 Redis Key 鍒楄〃', N'infra:redis:get-key-list', 3, 2, 113, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-01-26 01:02:52', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1070, N'浠ｇ爜鐢熸垚妗堜緥', N'', 1, 1, 2, N'demo', N'ep:aim', N'infra/testDemo/index', NULL, 0, N'1', N'1', N'1', N'', N'2021-02-06 12:42:49', N'1', N'2023-11-15 23:45:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1075, N'浠诲姟瑙﹀彂', N'infra:job:trigger', 3, 8, 110, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-02-07 13:03:10', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1077, N'閾捐矾杩借釜', N'', 2, 4, 2740, N'skywalking', N'fa:eye', N'infra/skywalking/index', N'InfraSkyWalking', 0, N'1', N'1', N'1', N'', N'2021-02-08 20:41:31', N'1', N'2024-04-23 00:07:15', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1078, N'璁块棶鏃ュ織', N'', 2, 1, 1083, N'api-access-log', N'ep:place', N'infra/apiAccessLog/index', N'InfraApiAccessLog', 0, N'1', N'1', N'1', N'', N'2021-02-26 01:32:59', N'1', N'2024-02-29 08:54:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1082, N'鏃ュ織瀵煎嚭', N'infra:api-access-log:export', 3, 2, 1078, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-02-26 01:32:59', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1083, N'API 鏃ュ織', N'', 2, 4, 2, N'log', N'fa:tasks', NULL, NULL, 0, N'1', N'1', N'1', N'', N'2021-02-26 02:18:24', N'1', N'2024-04-22 23:58:36', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1084, N'閿欒鏃ュ織', N'infra:api-error-log:query', 2, 2, 1083, N'api-error-log', N'ep:warning-filled', N'infra/apiErrorLog/index', N'InfraApiErrorLog', 0, N'1', N'1', N'1', N'', N'2021-02-26 07:53:20', N'1', N'2024-02-29 08:55:17', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1085, N'鏃ュ織澶勭悊', N'infra:api-error-log:update-status', 3, 2, 1084, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-02-26 07:53:20', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1086, N'鏃ュ織瀵煎嚭', N'infra:api-error-log:export', 3, 3, 1084, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-02-26 07:53:20', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1087, N'浠诲姟鏌ヨ', N'infra:job:query', 3, 1, 110, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2021-03-10 01:26:19', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1088, N'鏃ュ織鏌ヨ', N'infra:api-access-log:query', 3, 1, 1078, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2021-03-10 01:28:04', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1089, N'鏃ュ織鏌ヨ', N'infra:api-error-log:query', 3, 1, 1084, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2021-03-10 01:29:09', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1090, N'鏂囦欢鍒楄〃', N'', 2, 5, 1243, N'file', N'ep:upload-filled', N'infra/file/index', N'InfraFile', 0, N'1', N'1', N'1', N'', N'2021-03-12 20:16:20', N'1', N'2024-02-29 08:53:02', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1091, N'鏂囦欢鏌ヨ', N'infra:file:query', 3, 1, 1090, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-03-12 20:16:20', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1092, N'鏂囦欢鍒犻櫎', N'infra:file:delete', 3, 4, 1090, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-03-12 20:16:20', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1093, N'鐭俊绠＄悊', N'', 1, 1, 2739, N'sms', N'ep:message', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2021-04-05 01:10:16', N'1', N'2024-04-22 23:56:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1094, N'鐭俊娓犻亾', N'', 2, 0, 1093, N'sms-channel', N'fa:stack-exchange', N'system/sms/channel/index', N'SystemSmsChannel', 0, N'1', N'1', N'1', N'', N'2021-04-01 11:07:15', N'1', N'2024-02-29 01:15:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1095, N'鐭俊娓犻亾鏌ヨ', N'system:sms-channel:query', 3, 1, 1094, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-04-01 11:07:15', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1096, N'鐭俊娓犻亾鍒涘缓', N'system:sms-channel:create', 3, 2, 1094, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-04-01 11:07:15', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1097, N'鐭俊娓犻亾鏇存柊', N'system:sms-channel:update', 3, 3, 1094, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-04-01 11:07:15', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1098, N'鐭俊娓犻亾鍒犻櫎', N'system:sms-channel:delete', 3, 4, 1094, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-04-01 11:07:15', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1100, N'鐭俊妯℃澘', N'', 2, 1, 1093, N'sms-template', N'ep:connection', N'system/sms/template/index', N'SystemSmsTemplate', 0, N'1', N'1', N'1', N'', N'2021-04-01 17:35:17', N'1', N'2024-02-29 01:16:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1101, N'鐭俊妯℃澘鏌ヨ', N'system:sms-template:query', 3, 1, 1100, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-04-01 17:35:17', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1102, N'鐭俊妯℃澘鍒涘缓', N'system:sms-template:create', 3, 2, 1100, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-04-01 17:35:17', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1103, N'鐭俊妯℃澘鏇存柊', N'system:sms-template:update', 3, 3, 1100, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-04-01 17:35:17', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1104, N'鐭俊妯℃澘鍒犻櫎', N'system:sms-template:delete', 3, 4, 1100, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-04-01 17:35:17', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1105, N'鐭俊妯℃澘瀵煎嚭', N'system:sms-template:export', 3, 5, 1100, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-04-01 17:35:17', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1106, N'鍙戦€佹祴璇曠煭淇?, N'system:sms-template:send-sms', 3, 6, 1100, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2021-04-11 00:26:40', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1107, N'鐭俊鏃ュ織', N'', 2, 2, 1093, N'sms-log', N'fa:edit', N'system/sms/log/index', N'SystemSmsLog', 0, N'1', N'1', N'1', N'', N'2021-04-11 08:37:05', N'1', N'2024-02-29 08:49:02', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1108, N'鐭俊鏃ュ織鏌ヨ', N'system:sms-log:query', 3, 1, 1107, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-04-11 08:37:05', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1109, N'鐭俊鏃ュ織瀵煎嚭', N'system:sms-log:export', 3, 5, 1107, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-04-11 08:37:05', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1117, N'鏀粯绠＄悊', N'', 1, 30, 0, N'/pay', N'ep:money', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2021-12-25 16:43:41', N'1', N'2024-02-29 08:58:38', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1118, N'璇峰亣鏌ヨ', N'', 2, 0, 5, N'leave', N'fa:leanpub', N'bpm/oa/leave/index', N'BpmOALeave', 0, N'1', N'1', N'1', N'', N'2021-09-20 08:51:03', N'1', N'2024-02-29 12:38:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1119, N'璇峰亣鐢宠鏌ヨ', N'bpm:oa-leave:query', 3, 1, 1118, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-09-20 08:51:03', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1120, N'璇峰亣鐢宠鍒涘缓', N'bpm:oa-leave:create', 3, 2, 1118, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-09-20 08:51:03', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1126, N'搴旂敤淇℃伅', N'', 2, 1, 1117, N'app', N'fa:apple', N'pay/app/index', N'PayApp', 0, N'1', N'1', N'1', N'', N'2021-11-10 01:13:30', N'1', N'2024-02-29 08:59:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1127, N'鏀粯搴旂敤淇℃伅鏌ヨ', N'pay:app:query', 3, 1, 1126, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-11-10 01:13:31', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1128, N'鏀粯搴旂敤淇℃伅鍒涘缓', N'pay:app:create', 3, 2, 1126, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-11-10 01:13:31', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1129, N'鏀粯搴旂敤淇℃伅鏇存柊', N'pay:app:update', 3, 3, 1126, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-11-10 01:13:31', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1130, N'鏀粯搴旂敤淇℃伅鍒犻櫎', N'pay:app:delete', 3, 4, 1126, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-11-10 01:13:31', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1132, N'绉橀挜瑙ｆ瀽', N'pay:channel:parsing', 3, 6, 1129, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2021-11-08 15:15:47', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1133, N'鏀粯鍟嗘埛淇℃伅鏌ヨ', N'pay:merchant:query', 3, 1, 1132, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-11-10 01:13:41', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1134, N'鏀粯鍟嗘埛淇℃伅鍒涘缓', N'pay:merchant:create', 3, 2, 1132, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-11-10 01:13:41', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1135, N'鏀粯鍟嗘埛淇℃伅鏇存柊', N'pay:merchant:update', 3, 3, 1132, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-11-10 01:13:41', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1136, N'鏀粯鍟嗘埛淇℃伅鍒犻櫎', N'pay:merchant:delete', 3, 4, 1132, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-11-10 01:13:41', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1137, N'鏀粯鍟嗘埛淇℃伅瀵煎嚭', N'pay:merchant:export', 3, 5, 1132, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-11-10 01:13:41', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1138, N'绉熸埛鍒楄〃', N'', 2, 0, 1224, N'list', N'ep:house', N'system/tenant/index', N'SystemTenant', 0, N'1', N'1', N'1', N'', N'2021-12-14 12:31:43', N'1', N'2024-02-29 01:01:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1139, N'绉熸埛鏌ヨ', N'system:tenant:query', 3, 1, 1138, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-14 12:31:44', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1140, N'绉熸埛鍒涘缓', N'system:tenant:create', 3, 2, 1138, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-14 12:31:44', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1141, N'绉熸埛鏇存柊', N'system:tenant:update', 3, 3, 1138, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-14 12:31:44', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1142, N'绉熸埛鍒犻櫎', N'system:tenant:delete', 3, 4, 1138, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-14 12:31:44', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1143, N'绉熸埛瀵煎嚭', N'system:tenant:export', 3, 5, 1138, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-14 12:31:44', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1150, N'绉橀挜瑙ｆ瀽', N'', 3, 6, 1129, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2021-11-08 15:15:47', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1161, N'閫€娆捐鍗?, N'', 2, 3, 1117, N'refund', N'fa:registered', N'pay/refund/index', N'PayRefund', 0, N'1', N'1', N'1', N'', N'2021-12-25 08:29:07', N'1', N'2024-02-29 08:59:20', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1162, N'閫€娆捐鍗曟煡璇?, N'pay:refund:query', 3, 1, 1161, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-25 08:29:07', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1166, N'閫€娆捐鍗曞鍑?, N'pay:refund:export', 3, 5, 1161, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-25 08:29:07', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1173, N'鏀粯璁㈠崟', N'', 2, 2, 1117, N'order', N'fa:cc-paypal', N'pay/order/index', N'PayOrder', 0, N'1', N'1', N'1', N'', N'2021-12-25 08:49:43', N'1', N'2024-02-29 08:59:43', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1174, N'鏀粯璁㈠崟鏌ヨ', N'pay:order:query', 3, 1, 1173, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-25 08:49:43', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1178, N'鏀粯璁㈠崟瀵煎嚭', N'pay:order:export', 3, 5, 1173, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-25 08:49:43', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1185, N'宸ヤ綔娴佺▼', N'', 1, 50, 0, N'/bpm', N'fa:medium', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2021-12-30 20:26:36', N'1', N'2024-02-29 12:43:43', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1186, N'娴佺▼绠＄悊', N'', 1, 10, 1185, N'manager', N'fa:dedent', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2021-12-30 20:28:30', N'1', N'2024-02-29 12:36:02', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1187, N'娴佺▼琛ㄥ崟', N'', 2, 2, 1186, N'form', N'fa:hdd-o', N'bpm/form/index', N'BpmForm', 0, N'1', N'1', N'1', N'', N'2021-12-30 12:38:22', N'1', N'2024-03-19 12:25:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1188, N'琛ㄥ崟鏌ヨ', N'bpm:form:query', 3, 1, 1187, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-30 12:38:22', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1189, N'琛ㄥ崟鍒涘缓', N'bpm:form:create', 3, 2, 1187, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-30 12:38:22', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1190, N'琛ㄥ崟鏇存柊', N'bpm:form:update', 3, 3, 1187, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-30 12:38:22', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1191, N'琛ㄥ崟鍒犻櫎', N'bpm:form:delete', 3, 4, 1187, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-30 12:38:22', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1192, N'琛ㄥ崟瀵煎嚭', N'bpm:form:export', 3, 5, 1187, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2021-12-30 12:38:22', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1193, N'娴佺▼妯″瀷', N'', 2, 1, 1186, N'model', N'fa-solid:project-diagram', N'bpm/model/index', N'BpmModel', 0, N'1', N'1', N'1', N'1', N'2021-12-31 23:24:58', N'1', N'2024-03-19 12:25:19', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1194, N'妯″瀷鏌ヨ', N'bpm:model:query', 3, 1, 1193, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-03 19:01:10', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1195, N'妯″瀷鍒涘缓', N'bpm:model:create', 3, 2, 1193, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-03 19:01:24', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1197, N'妯″瀷鏇存柊', N'bpm:model:update', 3, 4, 1193, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-03 19:02:28', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1198, N'妯″瀷鍒犻櫎', N'bpm:model:delete', 3, 5, 1193, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-03 19:02:43', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1199, N'妯″瀷鍙戝竷', N'bpm:model:deploy', 3, 6, 1193, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-03 19:03:24', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1200, N'瀹℃壒涓績', N'', 2, 20, 1185, N'task', N'fa:tasks', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-07 23:51:48', N'1', N'2024-03-21 00:33:15', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1201, N'鎴戠殑娴佺▼', N'', 2, 1, 1200, N'my', N'fa-solid:book', N'bpm/processInstance/index', N'BpmProcessInstanceMy', 0, N'1', N'1', N'1', N'', N'2022-01-07 15:53:44', N'1', N'2024-03-21 23:52:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1202, N'娴佺▼瀹炰緥鐨勬煡璇?, N'bpm:process-instance:query', 3, 1, 1201, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-01-07 15:53:44', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1207, N'寰呭姙浠诲姟', N'', 2, 10, 1200, N'todo', N'fa:slack', N'bpm/task/todo/index', N'BpmTodoTask', 0, N'1', N'1', N'1', N'1', N'2022-01-08 10:33:37', N'1', N'2024-02-29 12:37:39', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1208, N'宸插姙浠诲姟', N'', 2, 20, 1200, N'done', N'fa:delicious', N'bpm/task/done/index', N'BpmDoneTask', 0, N'1', N'1', N'1', N'1', N'2022-01-08 10:34:13', N'1', N'2024-02-29 12:37:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1209, N'鐢ㄦ埛鍒嗙粍', N'', 2, 4, 1186, N'user-group', N'fa:user-secret', N'bpm/group/index', N'BpmUserGroup', 0, N'1', N'1', N'1', N'', N'2022-01-14 02:14:20', N'1', N'2024-03-21 23:55:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1210, N'鐢ㄦ埛缁勬煡璇?, N'bpm:user-group:query', 3, 1, 1209, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-01-14 02:14:20', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1211, N'鐢ㄦ埛缁勫垱寤?, N'bpm:user-group:create', 3, 2, 1209, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-01-14 02:14:20', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1212, N'鐢ㄦ埛缁勬洿鏂?, N'bpm:user-group:update', 3, 3, 1209, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-01-14 02:14:20', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1213, N'鐢ㄦ埛缁勫垹闄?, N'bpm:user-group:delete', 3, 4, 1209, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-01-14 02:14:20', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1215, N'娴佺▼瀹氫箟鏌ヨ', N'bpm:process-definition:query', 3, 10, 1193, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-23 00:21:43', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1216, N'娴佺▼浠诲姟鍒嗛厤瑙勫垯鏌ヨ', N'bpm:task-assign-rule:query', 3, 20, 1193, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-23 00:26:53', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1217, N'娴佺▼浠诲姟鍒嗛厤瑙勫垯鍒涘缓', N'bpm:task-assign-rule:create', 3, 21, 1193, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-23 00:28:15', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1218, N'娴佺▼浠诲姟鍒嗛厤瑙勫垯鏇存柊', N'bpm:task-assign-rule:update', 3, 22, 1193, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-23 00:28:41', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1219, N'娴佺▼瀹炰緥鐨勫垱寤?, N'bpm:process-instance:create', 3, 2, 1201, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-23 00:36:15', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1220, N'娴佺▼瀹炰緥鐨勫彇娑?, N'bpm:process-instance:cancel', 3, 3, 1201, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-23 00:36:33', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1221, N'娴佺▼浠诲姟鐨勬煡璇?, N'bpm:task:query', 3, 1, 1207, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-23 00:38:52', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1222, N'娴佺▼浠诲姟鐨勬洿鏂?, N'bpm:task:update', 3, 2, 1207, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-01-23 00:39:24', N'1', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1224, N'绉熸埛绠＄悊', N'', 2, 0, 1, N'tenant', N'fa-solid:house-user', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2022-02-20 01:41:13', N'1', N'2024-02-29 00:59:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1225, N'绉熸埛濂楅', N'', 2, 0, 1224, N'package', N'fa:bars', N'system/tenantPackage/index', N'SystemTenantPackage', 0, N'1', N'1', N'1', N'', N'2022-02-19 17:44:06', N'1', N'2024-02-29 01:01:43', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1226, N'绉熸埛濂楅鏌ヨ', N'system:tenant-package:query', 3, 1, 1225, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-02-19 17:44:06', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1227, N'绉熸埛濂楅鍒涘缓', N'system:tenant-package:create', 3, 2, 1225, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-02-19 17:44:06', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1228, N'绉熸埛濂楅鏇存柊', N'system:tenant-package:update', 3, 3, 1225, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-02-19 17:44:06', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1229, N'绉熸埛濂楅鍒犻櫎', N'system:tenant-package:delete', 3, 4, 1225, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-02-19 17:44:06', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1237, N'鏂囦欢閰嶇疆', N'', 2, 0, 1243, N'file-config', N'fa-solid:file-signature', N'infra/fileConfig/index', N'InfraFileConfig', 0, N'1', N'1', N'1', N'', N'2022-03-15 14:35:28', N'1', N'2024-02-29 08:52:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1238, N'鏂囦欢閰嶇疆鏌ヨ', N'infra:file-config:query', 3, 1, 1237, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-03-15 14:35:28', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1239, N'鏂囦欢閰嶇疆鍒涘缓', N'infra:file-config:create', 3, 2, 1237, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-03-15 14:35:28', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1240, N'鏂囦欢閰嶇疆鏇存柊', N'infra:file-config:update', 3, 3, 1237, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-03-15 14:35:28', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1241, N'鏂囦欢閰嶇疆鍒犻櫎', N'infra:file-config:delete', 3, 4, 1237, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-03-15 14:35:28', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1242, N'鏂囦欢閰嶇疆瀵煎嚭', N'infra:file-config:export', 3, 5, 1237, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-03-15 14:35:28', N'', N'2022-04-20 17:03:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1243, N'鏂囦欢绠＄悊', N'', 2, 6, 2, N'file', N'ep:files', NULL, N'', 0, N'1', N'1', N'1', N'1', N'2022-03-16 23:47:40', N'1', N'2024-04-23 00:02:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1254, N'浣滆€呭姩鎬?, N'', 1, 0, 0, N'https://www.iocoder.cn', N'ep:avatar', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2022-04-23 01:03:15', N'1', N'2025-04-29 17:45:38', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1255, N'鏁版嵁婧愰厤缃?, N'', 2, 1, 2, N'data-source-config', N'ep:data-analysis', N'infra/dataSourceConfig/index', N'InfraDataSourceConfig', 0, N'1', N'1', N'1', N'', N'2022-04-27 14:37:32', N'1', N'2024-02-29 08:51:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1256, N'鏁版嵁婧愰厤缃煡璇?, N'infra:data-source-config:query', 3, 1, 1255, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-04-27 14:37:32', N'', N'2022-04-27 14:37:32', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1257, N'鏁版嵁婧愰厤缃垱寤?, N'infra:data-source-config:create', 3, 2, 1255, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-04-27 14:37:32', N'', N'2022-04-27 14:37:32', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1258, N'鏁版嵁婧愰厤缃洿鏂?, N'infra:data-source-config:update', 3, 3, 1255, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-04-27 14:37:32', N'', N'2022-04-27 14:37:32', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1259, N'鏁版嵁婧愰厤缃垹闄?, N'infra:data-source-config:delete', 3, 4, 1255, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-04-27 14:37:32', N'', N'2022-04-27 14:37:32', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1260, N'鏁版嵁婧愰厤缃鍑?, N'infra:data-source-config:export', 3, 5, 1255, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-04-27 14:37:32', N'', N'2022-04-27 14:37:32', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1261, N'OAuth 2.0', N'', 2, 10, 1, N'oauth2', N'fa:dashcube', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2022-05-09 23:38:17', N'1', N'2024-02-29 01:12:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1263, N'搴旂敤绠＄悊', N'', 2, 0, 1261, N'oauth2/application', N'fa:hdd-o', N'system/oauth2/client/index', N'SystemOAuth2Client', 0, N'1', N'1', N'1', N'', N'2022-05-10 16:26:33', N'1', N'2024-02-29 01:13:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1264, N'瀹㈡埛绔煡璇?, N'system:oauth2-client:query', 3, 1, 1263, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-05-10 16:26:33', N'1', N'2022-05-11 00:31:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1265, N'瀹㈡埛绔垱寤?, N'system:oauth2-client:create', 3, 2, 1263, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-05-10 16:26:33', N'1', N'2022-05-11 00:31:23', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1266, N'瀹㈡埛绔洿鏂?, N'system:oauth2-client:update', 3, 3, 1263, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-05-10 16:26:33', N'1', N'2022-05-11 00:31:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1267, N'瀹㈡埛绔垹闄?, N'system:oauth2-client:delete', 3, 4, 1263, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-05-10 16:26:33', N'1', N'2022-05-11 00:31:33', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1281, N'鎶ヨ〃绠＄悊', N'', 2, 40, 0, N'/report', N'ep:pie-chart', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2022-07-10 20:22:15', N'1', N'2024-02-29 12:33:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (1282, N'鎶ヨ〃璁捐鍣?, N'', 2, 1, 1281, N'jimu-report', N'ep:trend-charts', N'report/jmreport/index', N'JimuReport', 0, N'1', N'1', N'1', N'1', N'2022-07-10 20:26:36', N'1', N'2025-05-03 09:57:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2000, N'鍟嗗搧涓績', N'', 1, 60, 2362, N'product', N'fa:product-hunt', NULL, NULL, 0, N'1', N'1', N'1', N'', N'2022-07-29 15:53:53', N'1', N'2023-09-30 11:52:36', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2002, N'鍟嗗搧鍒嗙被', N'', 2, 2, 2000, N'category', N'ep:cellphone', N'mall/product/category/index', N'ProductCategory', 0, N'1', N'1', N'1', N'', N'2022-07-29 15:53:53', N'1', N'2023-08-21 10:27:15', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2003, N'鍒嗙被鏌ヨ', N'product:category:query', 3, 1, 2002, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-07-29 15:53:53', N'', N'2022-07-29 15:53:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2004, N'鍒嗙被鍒涘缓', N'product:category:create', 3, 2, 2002, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-07-29 15:53:53', N'', N'2022-07-29 15:53:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2005, N'鍒嗙被鏇存柊', N'product:category:update', 3, 3, 2002, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-07-29 15:53:53', N'', N'2022-07-29 15:53:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2006, N'鍒嗙被鍒犻櫎', N'product:category:delete', 3, 4, 2002, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-07-29 15:53:53', N'', N'2022-07-29 15:53:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2008, N'鍟嗗搧鍝佺墝', N'', 2, 3, 2000, N'brand', N'ep:chicken', N'mall/product/brand/index', N'ProductBrand', 0, N'1', N'1', N'1', N'', N'2022-07-30 13:52:44', N'1', N'2023-08-21 10:27:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2009, N'鍝佺墝鏌ヨ', N'product:brand:query', 3, 1, 2008, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-07-30 13:52:44', N'', N'2022-07-30 13:52:44', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2010, N'鍝佺墝鍒涘缓', N'product:brand:create', 3, 2, 2008, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-07-30 13:52:44', N'', N'2022-07-30 13:52:44', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2011, N'鍝佺墝鏇存柊', N'product:brand:update', 3, 3, 2008, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-07-30 13:52:44', N'', N'2022-07-30 13:52:44', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2012, N'鍝佺墝鍒犻櫎', N'product:brand:delete', 3, 4, 2008, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-07-30 13:52:44', N'', N'2022-07-30 13:52:44', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2014, N'鍟嗗搧鍒楄〃', N'', 2, 1, 2000, N'spu', N'ep:apple', N'mall/product/spu/index', N'ProductSpu', 0, N'1', N'1', N'1', N'', N'2022-07-30 14:22:58', N'1', N'2023-08-21 10:27:01', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2015, N'鍟嗗搧鏌ヨ', N'product:spu:query', 3, 1, 2014, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-07-30 14:22:58', N'', N'2022-07-30 14:22:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2016, N'鍟嗗搧鍒涘缓', N'product:spu:create', 3, 2, 2014, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-07-30 14:22:58', N'', N'2022-07-30 14:22:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2017, N'鍟嗗搧鏇存柊', N'product:spu:update', 3, 3, 2014, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-07-30 14:22:58', N'', N'2022-07-30 14:22:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2018, N'鍟嗗搧鍒犻櫎', N'product:spu:delete', 3, 4, 2014, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-07-30 14:22:58', N'', N'2022-07-30 14:22:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2019, N'鍟嗗搧灞炴€?, N'', 2, 4, 2000, N'property', N'ep:cold-drink', N'mall/product/property/index', N'ProductProperty', 0, N'1', N'1', N'1', N'', N'2022-08-01 14:55:35', N'1', N'2023-08-26 11:01:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2020, N'瑙勬牸鏌ヨ', N'product:property:query', 3, 1, 2019, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-08-01 14:55:35', N'', N'2022-12-12 20:26:24', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2021, N'瑙勬牸鍒涘缓', N'product:property:create', 3, 2, 2019, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-08-01 14:55:35', N'', N'2022-12-12 20:26:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2022, N'瑙勬牸鏇存柊', N'product:property:update', 3, 3, 2019, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-08-01 14:55:35', N'', N'2022-12-12 20:26:33', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2023, N'瑙勬牸鍒犻櫎', N'product:property:delete', 3, 4, 2019, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-08-01 14:55:35', N'', N'2022-12-12 20:26:37', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2025, N'Banner', N'', 2, 100, 2387, N'banner', N'fa:bandcamp', N'mall/promotion/banner/index', NULL, 0, N'1', N'1', N'1', N'', N'2022-08-01 14:56:14', N'1', N'2023-10-24 20:20:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2026, N'Banner鏌ヨ', N'promotion:banner:query', 3, 1, 2025, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2022-08-01 14:56:14', N'1', N'2023-10-24 20:20:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2027, N'Banner鍒涘缓', N'promotion:banner:create', 3, 2, 2025, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2022-08-01 14:56:14', N'1', N'2023-10-24 20:20:23', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2028, N'Banner鏇存柊', N'promotion:banner:update', 3, 3, 2025, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2022-08-01 14:56:14', N'1', N'2023-10-24 20:20:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2029, N'Banner鍒犻櫎', N'promotion:banner:delete', 3, 4, 2025, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2022-08-01 14:56:14', N'1', N'2023-10-24 20:20:36', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2030, N'钀ラ攢涓績', N'', 1, 70, 2362, N'promotion', N'ep:present', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2022-10-31 21:25:09', N'1', N'2023-09-30 11:54:27', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2032, N'浼樻儬鍔靛垪琛?, N'', 2, 1, 2365, N'template', N'ep:discount', N'mall/promotion/coupon/template/index', N'PromotionCouponTemplate', 0, N'1', N'1', N'1', N'', N'2022-10-31 22:27:14', N'1', N'2023-10-03 12:40:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2033, N'浼樻儬鍔垫ā鏉挎煡璇?, N'promotion:coupon-template:query', 3, 1, 2032, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-10-31 22:27:14', N'', N'2022-10-31 22:27:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2034, N'浼樻儬鍔垫ā鏉垮垱寤?, N'promotion:coupon-template:create', 3, 2, 2032, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-10-31 22:27:14', N'', N'2022-10-31 22:27:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2035, N'浼樻儬鍔垫ā鏉挎洿鏂?, N'promotion:coupon-template:update', 3, 3, 2032, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-10-31 22:27:14', N'', N'2022-10-31 22:27:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2036, N'浼樻儬鍔垫ā鏉垮垹闄?, N'promotion:coupon-template:delete', 3, 4, 2032, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-10-31 22:27:14', N'', N'2022-10-31 22:27:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2038, N'棰嗗彇璁板綍', N'', 2, 2, 2365, N'list', N'ep:collection-tag', N'mall/promotion/coupon/index', N'PromotionCoupon', 0, N'1', N'1', N'1', N'', N'2022-11-03 23:21:31', N'1', N'2023-10-03 12:55:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2039, N'浼樻儬鍔垫煡璇?, N'promotion:coupon:query', 3, 1, 2038, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-03 23:21:31', N'', N'2022-11-03 23:21:31', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2040, N'浼樻儬鍔靛垹闄?, N'promotion:coupon:delete', 3, 4, 2038, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-03 23:21:31', N'', N'2022-11-03 23:21:31', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2041, N'婊″噺閫?, N'', 2, 10, 2390, N'reward-activity', N'ep:goblet-square-full', N'mall/promotion/rewardActivity/index', N'PromotionRewardActivity', 0, N'1', N'1', N'1', N'', N'2022-11-04 23:47:49', N'1', N'2023-10-21 19:24:46', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2042, N'婊″噺閫佹椿鍔ㄦ煡璇?, N'promotion:reward-activity:query', 3, 1, 2041, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-04 23:47:49', N'', N'2022-11-04 23:47:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2043, N'婊″噺閫佹椿鍔ㄥ垱寤?, N'promotion:reward-activity:create', 3, 2, 2041, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-04 23:47:49', N'', N'2022-11-04 23:47:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2044, N'婊″噺閫佹椿鍔ㄦ洿鏂?, N'promotion:reward-activity:update', 3, 3, 2041, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-04 23:47:50', N'', N'2022-11-04 23:47:50', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2045, N'婊″噺閫佹椿鍔ㄥ垹闄?, N'promotion:reward-activity:delete', 3, 4, 2041, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-04 23:47:50', N'', N'2022-11-04 23:47:50', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2046, N'婊″噺閫佹椿鍔ㄥ叧闂?, N'promotion:reward-activity:close', 3, 5, 2041, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2022-11-05 10:42:53', N'1', N'2022-11-05 10:42:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2047, N'闄愭椂鎶樻墸', N'', 2, 7, 2390, N'discount-activity', N'ep:timer', N'mall/promotion/discountActivity/index', N'PromotionDiscountActivity', 0, N'1', N'1', N'1', N'', N'2022-11-05 17:12:15', N'1', N'2023-10-21 19:24:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2048, N'闄愭椂鎶樻墸娲诲姩鏌ヨ', N'promotion:discount-activity:query', 3, 1, 2047, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-05 17:12:15', N'', N'2022-11-05 17:12:15', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2049, N'闄愭椂鎶樻墸娲诲姩鍒涘缓', N'promotion:discount-activity:create', 3, 2, 2047, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-05 17:12:15', N'', N'2022-11-05 17:12:15', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2050, N'闄愭椂鎶樻墸娲诲姩鏇存柊', N'promotion:discount-activity:update', 3, 3, 2047, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-05 17:12:16', N'', N'2022-11-05 17:12:16', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2051, N'闄愭椂鎶樻墸娲诲姩鍒犻櫎', N'promotion:discount-activity:delete', 3, 4, 2047, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-05 17:12:16', N'', N'2022-11-05 17:12:16', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2052, N'闄愭椂鎶樻墸娲诲姩鍏抽棴', N'promotion:discount-activity:close', 3, 5, 2047, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-05 17:12:16', N'', N'2022-11-05 17:12:16', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2059, N'绉掓潃鍟嗗搧', N'', 2, 2, 2209, N'activity', N'ep:basketball', N'mall/promotion/seckill/activity/index', N'PromotionSeckillActivity', 0, N'1', N'1', N'1', N'', N'2022-11-06 22:24:49', N'1', N'2023-06-24 18:57:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2060, N'绉掓潃娲诲姩鏌ヨ', N'promotion:seckill-activity:query', 3, 1, 2059, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-06 22:24:49', N'', N'2022-11-06 22:24:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2061, N'绉掓潃娲诲姩鍒涘缓', N'promotion:seckill-activity:create', 3, 2, 2059, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-06 22:24:49', N'', N'2022-11-06 22:24:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2062, N'绉掓潃娲诲姩鏇存柊', N'promotion:seckill-activity:update', 3, 3, 2059, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-06 22:24:49', N'', N'2022-11-06 22:24:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2063, N'绉掓潃娲诲姩鍒犻櫎', N'promotion:seckill-activity:delete', 3, 4, 2059, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-06 22:24:49', N'', N'2022-11-06 22:24:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2066, N'绉掓潃鏃舵', N'', 2, 1, 2209, N'config', N'ep:baseball', N'mall/promotion/seckill/config/index', N'PromotionSeckillConfig', 0, N'1', N'1', N'1', N'', N'2022-11-15 19:46:50', N'1', N'2023-06-24 18:57:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2067, N'绉掓潃鏃舵鏌ヨ', N'promotion:seckill-config:query', 3, 1, 2066, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2022-11-15 19:46:51', N'1', N'2023-06-24 17:50:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2068, N'绉掓潃鏃舵鍒涘缓', N'promotion:seckill-config:create', 3, 2, 2066, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2022-11-15 19:46:51', N'1', N'2023-06-24 17:48:39', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2069, N'绉掓潃鏃舵鏇存柊', N'promotion:seckill-config:update', 3, 3, 2066, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2022-11-15 19:46:51', N'1', N'2023-06-24 17:50:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2070, N'绉掓潃鏃舵鍒犻櫎', N'promotion:seckill-config:delete', 3, 4, 2066, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2022-11-15 19:46:51', N'1', N'2023-06-24 17:50:32', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2072, N'璁㈠崟涓績', N'', 1, 65, 2362, N'trade', N'ep:eleme', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2022-11-19 18:57:19', N'1', N'2023-09-30 11:54:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2073, N'鍞悗閫€娆?, N'', 2, 2, 2072, N'after-sale', N'ep:refrigerator', N'mall/trade/afterSale/index', N'TradeAfterSale', 0, N'1', N'1', N'1', N'', N'2022-11-19 20:15:32', N'1', N'2023-10-01 21:42:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2074, N'鍞悗鏌ヨ', N'trade:after-sale:query', 3, 1, 2073, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-11-19 20:15:33', N'1', N'2022-12-10 21:04:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2075, N'绉掓潃娲诲姩鍏抽棴', N'promotion:seckill-activity:close', 3, 5, 2059, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2022-11-28 20:20:15', N'1', N'2023-10-03 18:34:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2076, N'璁㈠崟鍒楄〃', N'', 2, 1, 2072, N'order', N'ep:list', N'mall/trade/order/index', N'TradeOrder', 0, N'1', N'1', N'1', N'1', N'2022-12-10 21:05:44', N'1', N'2023-10-01 21:42:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2083, N'鍦板尯绠＄悊', N'', 2, 14, 1, N'area', N'fa:map-marker', N'system/area/index', N'SystemArea', 0, N'1', N'1', N'1', N'1', N'2022-12-23 17:35:05', N'1', N'2024-02-29 08:50:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2084, N'鍏紬鍙风鐞?, N'', 1, 100, 0, N'/mp', N'ep:compass', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-01 20:11:04', N'1', N'2024-02-29 12:39:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2085, N'璐﹀彿绠＄悊', N'', 2, 1, 2084, N'account', N'fa:user', N'mp/account/index', N'MpAccount', 0, N'1', N'1', N'1', N'1', N'2023-01-01 20:13:31', N'1', N'2024-02-29 12:42:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2086, N'鏂板璐﹀彿', N'mp:account:create', 3, 1, 2085, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-01 20:21:40', N'1', N'2023-01-07 17:32:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2087, N'淇敼璐﹀彿', N'mp:account:update', 3, 2, 2085, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-07 17:32:46', N'1', N'2023-01-07 17:32:46', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2088, N'鏌ヨ璐﹀彿', N'mp:account:query', 3, 0, 2085, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-07 17:33:07', N'1', N'2023-01-07 17:33:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2089, N'鍒犻櫎璐﹀彿', N'mp:account:delete', 3, 3, 2085, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-07 17:33:21', N'1', N'2023-01-07 17:33:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2090, N'鐢熸垚浜岀淮鐮?, N'mp:account:qr-code', 3, 4, 2085, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-07 17:33:58', N'1', N'2023-01-07 17:33:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2091, N'娓呯┖ API 閰嶉', N'mp:account:clear-quota', 3, 5, 2085, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-07 18:20:32', N'1', N'2023-01-07 18:20:59', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2092, N'鏁版嵁缁熻', N'mp:statistics:query', 2, 2, 2084, N'statistics', N'ep:trend-charts', N'mp/statistics/index', N'MpStatistics', 0, N'1', N'1', N'1', N'1', N'2023-01-07 20:17:36', N'1', N'2024-02-29 12:42:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2093, N'鏍囩绠＄悊', N'', 2, 3, 2084, N'tag', N'ep:collection-tag', N'mp/tag/index', N'MpTag', 0, N'1', N'1', N'1', N'1', N'2023-01-08 11:37:32', N'1', N'2024-02-29 12:42:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2094, N'鏌ヨ鏍囩', N'mp:tag:query', 3, 0, 2093, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-08 11:59:03', N'1', N'2023-01-08 11:59:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2095, N'鏂板鏍囩', N'mp:tag:create', 3, 1, 2093, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-08 11:59:23', N'1', N'2023-01-08 11:59:23', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2096, N'淇敼鏍囩', N'mp:tag:update', 3, 2, 2093, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-08 11:59:41', N'1', N'2023-01-08 11:59:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2097, N'鍒犻櫎鏍囩', N'mp:tag:delete', 3, 3, 2093, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-08 12:00:04', N'1', N'2023-01-08 12:00:13', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2098, N'鍚屾鏍囩', N'mp:tag:sync', 3, 4, 2093, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-08 12:00:29', N'1', N'2023-01-08 12:00:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2099, N'绮変笣绠＄悊', N'', 2, 4, 2084, N'user', N'fa:user-secret', N'mp/user/index', N'MpUser', 0, N'1', N'1', N'1', N'1', N'2023-01-08 16:51:20', N'1', N'2024-02-29 12:42:39', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2100, N'鏌ヨ绮変笣', N'mp:user:query', 3, 0, 2099, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-08 17:16:59', N'1', N'2023-01-08 17:17:23', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2101, N'淇敼绮変笣', N'mp:user:update', 3, 1, 2099, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-08 17:17:11', N'1', N'2023-01-08 17:17:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2102, N'鍚屾绮変笣', N'mp:user:sync', 3, 2, 2099, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-08 17:17:40', N'1', N'2023-01-08 17:17:40', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2103, N'娑堟伅绠＄悊', N'', 2, 5, 2084, N'message', N'ep:message', N'mp/message/index', N'MpMessage', 0, N'1', N'1', N'1', N'1', N'2023-01-08 18:44:19', N'1', N'2024-02-29 12:42:50', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2104, N'鍥炬枃鍙戣〃璁板綍', N'', 2, 10, 2084, N'free-publish', N'ep:edit-pen', N'mp/freePublish/index', N'MpFreePublish', 0, N'1', N'1', N'1', N'1', N'2023-01-13 00:30:50', N'1', N'2024-02-29 12:43:31', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2105, N'鏌ヨ鍙戝竷鍒楄〃', N'mp:free-publish:query', 3, 1, 2104, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-13 07:19:17', N'1', N'2023-01-13 07:19:17', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2106, N'鍙戝竷鑽夌', N'mp:free-publish:submit', 3, 2, 2104, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-13 07:19:46', N'1', N'2023-01-13 07:19:46', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2107, N'鍒犻櫎鍙戝竷璁板綍', N'mp:free-publish:delete', 3, 3, 2104, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-13 07:20:01', N'1', N'2023-01-13 07:20:01', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2108, N'鍥炬枃鑽夌绠?, N'', 2, 9, 2084, N'draft', N'ep:edit', N'mp/draft/index', N'MpDraft', 0, N'1', N'1', N'1', N'1', N'2023-01-13 07:40:21', N'1', N'2024-02-29 12:43:26', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2109, N'鏂板缓鑽夌', N'mp:draft:create', 3, 1, 2108, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-13 23:15:30', N'1', N'2023-01-13 23:15:44', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2110, N'淇敼鑽夌', N'mp:draft:update', 3, 2, 2108, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-14 10:08:47', N'1', N'2023-01-14 10:08:47', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2111, N'鏌ヨ鑽夌', N'mp:draft:query', 3, 0, 2108, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-14 10:09:01', N'1', N'2023-01-14 10:09:01', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2112, N'鍒犻櫎鑽夌', N'mp:draft:delete', 3, 3, 2108, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-14 10:09:19', N'1', N'2023-01-14 10:09:19', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2113, N'绱犳潗绠＄悊', N'', 2, 8, 2084, N'material', N'ep:basketball', N'mp/material/index', N'MpMaterial', 0, N'1', N'1', N'1', N'1', N'2023-01-14 14:12:07', N'1', N'2024-02-29 12:43:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2114, N'涓婁紶涓存椂绱犳潗', N'mp:material:upload-temporary', 3, 1, 2113, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-14 15:33:55', N'1', N'2023-01-14 15:33:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2115, N'涓婁紶姘镐箙绱犳潗', N'mp:material:upload-permanent', 3, 2, 2113, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-14 15:34:14', N'1', N'2023-01-14 15:34:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2116, N'鍒犻櫎绱犳潗', N'mp:material:delete', 3, 3, 2113, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-14 15:35:37', N'1', N'2023-01-14 15:35:37', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2117, N'涓婁紶鍥炬枃鍥剧墖', N'mp:material:upload-news-image', 3, 4, 2113, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-14 15:36:31', N'1', N'2023-01-14 15:36:31', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2118, N'鏌ヨ绱犳潗', N'mp:material:query', 3, 5, 2113, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-14 15:39:22', N'1', N'2023-01-14 15:39:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2119, N'鑿滃崟绠＄悊', N'', 2, 6, 2084, N'menu', N'ep:menu', N'mp/menu/index', N'MpMenu', 0, N'1', N'1', N'1', N'1', N'2023-01-14 17:43:54', N'1', N'2025-04-01 20:21:02', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2120, N'鑷姩鍥炲', N'', 2, 7, 2084, N'auto-reply', N'fa-solid:republican', N'mp/autoReply/index', N'MpAutoReply', 0, N'1', N'1', N'1', N'1', N'2023-01-15 22:13:09', N'1', N'2024-02-29 12:43:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2121, N'鏌ヨ鍥炲', N'mp:auto-reply:query', 3, 0, 2120, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-16 22:28:41', N'1', N'2023-01-16 22:28:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2122, N'鏂板鍥炲', N'mp:auto-reply:create', 3, 1, 2120, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-16 22:28:54', N'1', N'2023-01-16 22:28:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2123, N'淇敼鍥炲', N'mp:auto-reply:update', 3, 2, 2120, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-16 22:29:05', N'1', N'2023-01-16 22:29:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2124, N'鍒犻櫎鍥炲', N'mp:auto-reply:delete', 3, 3, 2120, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-16 22:29:34', N'1', N'2023-01-16 22:29:34', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2125, N'鏌ヨ鑿滃崟', N'mp:menu:query', 3, 0, 2119, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-17 23:05:41', N'1', N'2023-01-17 23:05:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2126, N'淇濆瓨鑿滃崟', N'mp:menu:save', 3, 1, 2119, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-17 23:06:01', N'1', N'2023-01-17 23:06:01', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2127, N'鍒犻櫎鑿滃崟', N'mp:menu:delete', 3, 2, 2119, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-17 23:06:16', N'1', N'2023-01-17 23:06:16', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2128, N'鏌ヨ娑堟伅', N'mp:message:query', 3, 0, 2103, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-17 23:07:14', N'1', N'2023-01-17 23:07:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2129, N'鍙戦€佹秷鎭?, N'mp:message:send', 3, 1, 2103, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-17 23:07:26', N'1', N'2023-01-17 23:07:26', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2130, N'閭绠＄悊', N'', 2, 2, 2739, N'mail', N'fa-solid:mail-bulk', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-25 17:27:44', N'1', N'2024-04-22 23:56:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2131, N'閭璐﹀彿', N'', 2, 0, 2130, N'mail-account', N'fa:universal-access', N'system/mail/account/index', N'SystemMailAccount', 0, N'1', N'1', N'1', N'', N'2023-01-25 09:33:48', N'1', N'2024-02-29 08:48:16', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2132, N'璐﹀彿鏌ヨ', N'system:mail-account:query', 3, 1, 2131, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-25 09:33:48', N'', N'2023-01-25 09:33:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2133, N'璐﹀彿鍒涘缓', N'system:mail-account:create', 3, 2, 2131, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-25 09:33:48', N'', N'2023-01-25 09:33:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2134, N'璐﹀彿鏇存柊', N'system:mail-account:update', 3, 3, 2131, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-25 09:33:48', N'', N'2023-01-25 09:33:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2135, N'璐﹀彿鍒犻櫎', N'system:mail-account:delete', 3, 4, 2131, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-25 09:33:48', N'', N'2023-01-25 09:33:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2136, N'閭欢妯＄増', N'', 2, 0, 2130, N'mail-template', N'fa:tag', N'system/mail/template/index', N'SystemMailTemplate', 0, N'1', N'1', N'1', N'', N'2023-01-25 12:05:31', N'1', N'2024-02-29 08:48:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2137, N'妯＄増鏌ヨ', N'system:mail-template:query', 3, 1, 2136, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-25 12:05:31', N'', N'2023-01-25 12:05:31', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2138, N'妯＄増鍒涘缓', N'system:mail-template:create', 3, 2, 2136, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-25 12:05:31', N'', N'2023-01-25 12:05:31', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2139, N'妯＄増鏇存柊', N'system:mail-template:update', 3, 3, 2136, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-25 12:05:31', N'', N'2023-01-25 12:05:31', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2140, N'妯＄増鍒犻櫎', N'system:mail-template:delete', 3, 4, 2136, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-25 12:05:31', N'', N'2023-01-25 12:05:31', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2141, N'閭欢璁板綍', N'', 2, 0, 2130, N'mail-log', N'fa:edit', N'system/mail/log/index', N'SystemMailLog', 0, N'1', N'1', N'1', N'', N'2023-01-26 02:16:50', N'1', N'2024-02-29 08:48:51', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2142, N'鏃ュ織鏌ヨ', N'system:mail-log:query', 3, 1, 2141, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-26 02:16:50', N'', N'2023-01-26 02:16:50', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2143, N'鍙戦€佹祴璇曢偖浠?, N'system:mail-template:send-mail', 3, 5, 2136, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-26 23:29:15', N'1', N'2023-01-26 23:29:15', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2144, N'绔欏唴淇＄鐞?, N'', 1, 3, 2739, N'notify', N'ep:message-box', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-28 10:25:18', N'1', N'2024-04-22 23:56:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2145, N'妯℃澘绠＄悊', N'', 2, 0, 2144, N'notify-template', N'fa:archive', N'system/notify/template/index', N'SystemNotifyTemplate', 0, N'1', N'1', N'1', N'', N'2023-01-28 02:26:42', N'1', N'2024-02-29 08:49:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2146, N'绔欏唴淇℃ā鏉挎煡璇?, N'system:notify-template:query', 3, 1, 2145, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-28 02:26:42', N'', N'2023-01-28 02:26:42', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2147, N'绔欏唴淇℃ā鏉垮垱寤?, N'system:notify-template:create', 3, 2, 2145, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-28 02:26:42', N'', N'2023-01-28 02:26:42', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2148, N'绔欏唴淇℃ā鏉挎洿鏂?, N'system:notify-template:update', 3, 3, 2145, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-28 02:26:42', N'', N'2023-01-28 02:26:42', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2149, N'绔欏唴淇℃ā鏉垮垹闄?, N'system:notify-template:delete', 3, 4, 2145, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-28 02:26:42', N'', N'2023-01-28 02:26:42', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2150, N'鍙戦€佹祴璇曠珯鍐呬俊', N'system:notify-template:send-notify', 3, 5, 2145, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-01-28 10:54:43', N'1', N'2023-01-28 10:54:43', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2151, N'娑堟伅璁板綍', N'', 2, 0, 2144, N'notify-message', N'fa:edit', N'system/notify/message/index', N'SystemNotifyMessage', 0, N'1', N'1', N'1', N'', N'2023-01-28 04:28:22', N'1', N'2024-02-29 08:49:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2152, N'绔欏唴淇℃秷鎭煡璇?, N'system:notify-message:query', 3, 1, 2151, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-01-28 04:28:22', N'', N'2023-01-28 04:28:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2153, N'澶у睆璁捐鍣?, N'', 2, 2, 1281, N'go-view', N'fa:area-chart', N'report/goview/index', N'GoView', 0, N'1', N'1', N'1', N'1', N'2023-02-07 00:03:19', N'1', N'2025-05-03 09:57:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2154, N'鍒涘缓椤圭洰', N'report:go-view-project:create', 3, 1, 2153, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-02-07 19:25:14', N'1', N'2023-02-07 19:25:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2155, N'鏇存柊椤圭洰', N'report:go-view-project:update', 3, 2, 2153, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-02-07 19:25:34', N'1', N'2024-04-24 20:01:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2156, N'鏌ヨ椤圭洰', N'report:go-view-project:query', 3, 0, 2153, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-02-07 19:25:53', N'1', N'2023-02-07 19:25:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2157, N'浣跨敤 SQL 鏌ヨ鏁版嵁', N'report:go-view-data:get-by-sql', 3, 3, 2153, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-02-07 19:26:15', N'1', N'2023-02-07 19:26:15', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2158, N'浣跨敤 HTTP 鏌ヨ鏁版嵁', N'report:go-view-data:get-by-http', 3, 4, 2153, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'1', N'2023-02-07 19:26:35', N'1', N'2023-02-07 19:26:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2159, N'Boot 寮€鍙戞枃妗?, N'', 1, 1, 0, N'https://doc.iocoder.cn/', N'ep:document', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2023-02-10 22:46:28', N'1', N'2024-07-28 11:36:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2160, N'Cloud 寮€鍙戞枃妗?, N'', 1, 2, 0, N'https://cloud.iocoder.cn', N'ep:document-copy', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2023-02-10 22:47:07', N'1', N'2023-12-02 21:32:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2161, N'鎺ュ叆绀轰緥', N'', 1, 99, 1117, N'demo', N'fa-solid:dragon', N'pay/demo/index', NULL, 0, N'1', N'1', N'1', N'', N'2023-02-11 14:21:42', N'1', N'2024-01-18 23:50:00', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2162, N'鍟嗗搧瀵煎嚭', N'product:spu:export', 3, 5, 2014, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2022-07-30 14:22:58', N'', N'2022-07-30 14:22:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2164, N'閰嶉€佺鐞?, N'', 1, 3, 2072, N'delivery', N'ep:shopping-cart', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-05-18 09:18:02', N'1', N'2023-09-28 10:58:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2165, N'蹇€掑彂璐?, N'', 1, 0, 2164, N'express', N'ep:bicycle', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-05-18 09:22:06', N'1', N'2023-08-30 21:02:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2166, N'闂ㄥ簵鑷彁', N'', 1, 1, 2164, N'pick-up-store', N'ep:add-location', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-05-18 09:23:14', N'1', N'2023-08-30 21:03:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2167, N'蹇€掑叕鍙?, N'', 2, 0, 2165, N'express', N'ep:compass', N'mall/trade/delivery/express/index', N'Express', 0, N'1', N'1', N'1', N'1', N'2023-05-18 09:27:21', N'1', N'2024-11-29 11:20:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2168, N'蹇€掑叕鍙告煡璇?, N'trade:delivery:express:query', 3, 1, 2167, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-18 09:37:53', N'', N'2023-05-18 09:37:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2169, N'蹇€掑叕鍙稿垱寤?, N'trade:delivery:express:create', 3, 2, 2167, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-18 09:37:53', N'', N'2023-05-18 09:37:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2170, N'蹇€掑叕鍙告洿鏂?, N'trade:delivery:express:update', 3, 3, 2167, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-18 09:37:53', N'', N'2023-05-18 09:37:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2171, N'蹇€掑叕鍙稿垹闄?, N'trade:delivery:express:delete', 3, 4, 2167, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-18 09:37:53', N'', N'2023-05-18 09:37:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2172, N'蹇€掑叕鍙稿鍑?, N'trade:delivery:express:export', 3, 5, 2167, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-18 09:37:53', N'', N'2023-05-18 09:37:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2173, N'杩愯垂妯＄増', N'trade:delivery:express-template:query', 2, 1, 2165, N'express-template', N'ep:coordinate', N'mall/trade/delivery/expressTemplate/index', N'ExpressTemplate', 0, N'1', N'1', N'1', N'1', N'2023-05-20 06:48:10', N'1', N'2023-08-30 21:03:13', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2174, N'蹇€掕繍璐规ā鏉挎煡璇?, N'trade:delivery:express-template:query', 3, 1, 2173, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-20 06:49:53', N'', N'2023-05-20 06:49:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2175, N'蹇€掕繍璐规ā鏉垮垱寤?, N'trade:delivery:express-template:create', 3, 2, 2173, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-20 06:49:53', N'', N'2023-05-20 06:49:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2176, N'蹇€掕繍璐规ā鏉挎洿鏂?, N'trade:delivery:express-template:update', 3, 3, 2173, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-20 06:49:53', N'', N'2023-05-20 06:49:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2177, N'蹇€掕繍璐规ā鏉垮垹闄?, N'trade:delivery:express-template:delete', 3, 4, 2173, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-20 06:49:53', N'', N'2023-05-20 06:49:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2178, N'蹇€掕繍璐规ā鏉垮鍑?, N'trade:delivery:express-template:export', 3, 5, 2173, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-20 06:49:53', N'', N'2023-05-20 06:49:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2179, N'闂ㄥ簵绠＄悊', N'', 2, 1, 2166, N'pick-up-store', N'ep:basketball', N'mall/trade/delivery/pickUpStore/index', N'PickUpStore', 0, N'1', N'1', N'1', N'1', N'2023-05-25 10:50:00', N'1', N'2023-08-30 21:03:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2180, N'鑷彁闂ㄥ簵鏌ヨ', N'trade:delivery:pick-up-store:query', 3, 1, 2179, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-25 10:53:29', N'', N'2023-05-25 10:53:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2181, N'鑷彁闂ㄥ簵鍒涘缓', N'trade:delivery:pick-up-store:create', 3, 2, 2179, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-25 10:53:29', N'', N'2023-05-25 10:53:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2182, N'鑷彁闂ㄥ簵鏇存柊', N'trade:delivery:pick-up-store:update', 3, 3, 2179, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-25 10:53:29', N'', N'2023-05-25 10:53:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2183, N'鑷彁闂ㄥ簵鍒犻櫎', N'trade:delivery:pick-up-store:delete', 3, 4, 2179, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-25 10:53:29', N'', N'2023-05-25 10:53:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2184, N'鑷彁闂ㄥ簵瀵煎嚭', N'trade:delivery:pick-up-store:export', 3, 5, 2179, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-05-25 10:53:29', N'', N'2023-05-25 10:53:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2209, N'绉掓潃娲诲姩', N'', 2, 3, 2030, N'seckill', N'ep:place', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-06-24 17:39:13', N'1', N'2023-06-24 18:55:15', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2262, N'浼氬憳涓績', N'', 1, 55, 0, N'/member', N'ep:bicycle', NULL, NULL, 0, N'1', N'1', N'1', N'1', N'2023-06-10 00:42:03', N'1', N'2023-08-20 09:23:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2275, N'浼氬憳閰嶇疆', N'', 2, 0, 2262, N'config', N'fa:archive', N'member/config/index', N'MemberConfig', 0, N'1', N'1', N'1', N'', N'2023-06-10 02:07:44', N'1', N'2023-10-01 23:41:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2276, N'浼氬憳閰嶇疆鏌ヨ', N'member:config:query', 3, 1, 2275, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2023-06-10 02:07:44', N'1', N'2024-04-24 19:48:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2277, N'浼氬憳閰嶇疆淇濆瓨', N'member:config:save', 3, 2, 2275, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2023-06-10 02:07:44', N'1', N'2024-04-24 19:49:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2281, N'绛惧埌閰嶇疆', N'', 2, 2, 2300, N'config', N'ep:calendar', N'member/signin/config/index', N'SignInConfig', 0, N'1', N'1', N'1', N'', N'2023-06-10 03:26:12', N'1', N'2023-08-20 19:25:51', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2282, N'绉垎绛惧埌瑙勫垯鏌ヨ', N'point:sign-in-config:query', 3, 1, 2281, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-06-10 03:26:12', N'', N'2023-06-10 03:26:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2283, N'绉垎绛惧埌瑙勫垯鍒涘缓', N'point:sign-in-config:create', 3, 2, 2281, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-06-10 03:26:12', N'', N'2023-06-10 03:26:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2284, N'绉垎绛惧埌瑙勫垯鏇存柊', N'point:sign-in-config:update', 3, 3, 2281, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-06-10 03:26:12', N'', N'2023-06-10 03:26:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2285, N'绉垎绛惧埌瑙勫垯鍒犻櫎', N'point:sign-in-config:delete', 3, 4, 2281, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-06-10 03:26:12', N'', N'2023-06-10 03:26:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2287, N'浼氬憳绉垎', N'', 2, 10, 2262, N'record', N'fa:asterisk', N'member/point/record/index', N'PointRecord', 0, N'1', N'1', N'1', N'', N'2023-06-10 04:18:50', N'1', N'2023-10-01 23:42:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2288, N'鐢ㄦ埛绉垎璁板綍鏌ヨ', N'point:record:query', 3, 1, 2287, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-06-10 04:18:50', N'', N'2023-06-10 04:18:50', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2293, N'绛惧埌璁板綍', N'', 2, 3, 2300, N'record', N'ep:chicken', N'member/signin/record/index', N'SignInRecord', 0, N'1', N'1', N'1', N'', N'2023-06-10 04:48:22', N'1', N'2023-08-20 19:26:02', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2294, N'鐢ㄦ埛绛惧埌绉垎鏌ヨ', N'point:sign-in-record:query', 3, 1, 2293, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-06-10 04:48:22', N'', N'2023-06-10 04:48:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2297, N'鐢ㄦ埛绛惧埌绉垎鍒犻櫎', N'point:sign-in-record:delete', 3, 4, 2293, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-06-10 04:48:22', N'', N'2023-06-10 04:48:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2300, N'浼氬憳绛惧埌', N'', 1, 11, 2262, N'signin', N'ep:alarm-clock', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-06-27 22:49:53', N'1', N'2023-08-20 09:23:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2301, N'鍥炶皟閫氱煡', N'', 2, 5, 1117, N'notify', N'ep:mute-notification', N'pay/notify/index', N'PayNotify', 0, N'1', N'1', N'1', N'', N'2023-07-20 04:41:32', N'1', N'2024-01-18 23:56:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2302, N'鏀粯閫氱煡鏌ヨ', N'pay:notify:query', 3, 1, 2301, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-07-20 04:41:32', N'', N'2023-07-20 04:41:32', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2303, N'鎷煎洟娲诲姩', N'', 2, 3, 2030, N'combination', N'fa:group', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-12 17:19:54', N'1', N'2023-08-12 17:20:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2304, N'鎷煎洟鍟嗗搧', N'', 2, 1, 2303, N'acitivity', N'ep:apple', N'mall/promotion/combination/activity/index', N'PromotionCombinationActivity', 0, N'1', N'1', N'1', N'1', N'2023-08-12 17:22:03', N'1', N'2023-08-12 17:22:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2305, N'鎷煎洟娲诲姩鏌ヨ', N'promotion:combination-activity:query', 3, 1, 2304, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-12 17:54:32', N'1', N'2023-11-24 11:57:40', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2306, N'鎷煎洟娲诲姩鍒涘缓', N'promotion:combination-activity:create', 3, 2, 2304, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-12 17:54:49', N'1', N'2023-08-12 17:54:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2307, N'鎷煎洟娲诲姩鏇存柊', N'promotion:combination-activity:update', 3, 3, 2304, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-12 17:55:04', N'1', N'2023-08-12 17:55:04', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2308, N'鎷煎洟娲诲姩鍒犻櫎', N'promotion:combination-activity:delete', 3, 4, 2304, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-12 17:55:23', N'1', N'2023-08-12 17:55:23', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2309, N'鎷煎洟娲诲姩鍏抽棴', N'promotion:combination-activity:close', 3, 5, 2304, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-12 17:55:37', N'1', N'2023-10-06 10:51:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2310, N'鐮嶄环娲诲姩', N'', 2, 4, 2030, N'bargain', N'ep:box', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-13 00:27:25', N'1', N'2023-08-13 00:27:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2311, N'鐮嶄环鍟嗗搧', N'', 2, 1, 2310, N'activity', N'ep:burger', N'mall/promotion/bargain/activity/index', N'PromotionBargainActivity', 0, N'1', N'1', N'1', N'1', N'2023-08-13 00:28:49', N'1', N'2023-10-05 01:16:23', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2312, N'鐮嶄环娲诲姩鏌ヨ', N'promotion:bargain-activity:query', 3, 1, 2311, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-13 00:32:30', N'1', N'2023-08-13 00:32:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2313, N'鐮嶄环娲诲姩鍒涘缓', N'promotion:bargain-activity:create', 3, 2, 2311, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-13 00:32:44', N'1', N'2023-08-13 00:32:44', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2314, N'鐮嶄环娲诲姩鏇存柊', N'promotion:bargain-activity:update', 3, 3, 2311, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-13 00:32:55', N'1', N'2023-08-13 00:32:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2315, N'鐮嶄环娲诲姩鍒犻櫎', N'promotion:bargain-activity:delete', 3, 4, 2311, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-13 00:34:50', N'1', N'2023-08-13 00:34:50', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2316, N'鐮嶄环娲诲姩鍏抽棴', N'promotion:bargain-activity:close', 3, 5, 2311, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-13 00:35:02', N'1', N'2023-08-13 00:35:02', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2317, N'浼氬憳绠＄悊', N'', 2, 0, 2262, N'user', N'ep:avatar', N'member/user/index', N'MemberUser', 0, N'1', N'1', N'1', N'', N'2023-08-19 04:12:15', N'1', N'2023-08-24 00:50:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2318, N'浼氬憳鐢ㄦ埛鏌ヨ', N'member:user:query', 3, 1, 2317, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-19 04:12:15', N'', N'2023-08-19 04:12:15', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2319, N'浼氬憳鐢ㄦ埛鏇存柊', N'member:user:update', 3, 3, 2317, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-19 04:12:15', N'', N'2023-08-19 04:12:15', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2320, N'浼氬憳鏍囩', N'', 2, 1, 2262, N'tag', N'ep:collection-tag', N'member/tag/index', N'MemberTag', 0, N'1', N'1', N'1', N'', N'2023-08-20 01:03:08', N'1', N'2023-08-20 09:23:19', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2321, N'浼氬憳鏍囩鏌ヨ', N'member:tag:query', 3, 1, 2320, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-20 01:03:08', N'', N'2023-08-20 01:03:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2322, N'浼氬憳鏍囩鍒涘缓', N'member:tag:create', 3, 2, 2320, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-20 01:03:08', N'', N'2023-08-20 01:03:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2323, N'浼氬憳鏍囩鏇存柊', N'member:tag:update', 3, 3, 2320, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-20 01:03:08', N'', N'2023-08-20 01:03:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2324, N'浼氬憳鏍囩鍒犻櫎', N'member:tag:delete', 3, 4, 2320, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-20 01:03:08', N'', N'2023-08-20 01:03:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2325, N'浼氬憳绛夌骇', N'', 2, 2, 2262, N'level', N'fa:level-up', N'member/level/index', N'MemberLevel', 0, N'1', N'1', N'1', N'', N'2023-08-22 12:41:01', N'1', N'2023-08-22 21:47:00', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2326, N'浼氬憳绛夌骇鏌ヨ', N'member:level:query', 3, 1, 2325, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-22 12:41:02', N'', N'2023-08-22 12:41:02', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2327, N'浼氬憳绛夌骇鍒涘缓', N'member:level:create', 3, 2, 2325, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-22 12:41:02', N'', N'2023-08-22 12:41:02', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2328, N'浼氬憳绛夌骇鏇存柊', N'member:level:update', 3, 3, 2325, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-22 12:41:02', N'', N'2023-08-22 12:41:02', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2329, N'浼氬憳绛夌骇鍒犻櫎', N'member:level:delete', 3, 4, 2325, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-22 12:41:02', N'', N'2023-08-22 12:41:02', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2330, N'浼氬憳鍒嗙粍', N'', 2, 3, 2262, N'group', N'fa:group', N'member/group/index', N'MemberGroup', 0, N'1', N'1', N'1', N'', N'2023-08-22 13:50:06', N'1', N'2023-10-01 23:42:01', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2331, N'鐢ㄦ埛鍒嗙粍鏌ヨ', N'member:group:query', 3, 1, 2330, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-22 13:50:06', N'', N'2023-08-22 13:50:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2332, N'鐢ㄦ埛鍒嗙粍鍒涘缓', N'member:group:create', 3, 2, 2330, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-22 13:50:06', N'', N'2023-08-22 13:50:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2333, N'鐢ㄦ埛鍒嗙粍鏇存柊', N'member:group:update', 3, 3, 2330, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-22 13:50:06', N'', N'2023-08-22 13:50:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2334, N'鐢ㄦ埛鍒嗙粍鍒犻櫎', N'member:group:delete', 3, 4, 2330, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-22 13:50:06', N'', N'2023-08-22 13:50:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2335, N'鐢ㄦ埛绛夌骇淇敼', N'member:user:update-level', 3, 5, 2317, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-08-23 16:49:05', N'', N'2023-08-23 16:50:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2336, N'鍟嗗搧璇勮', N'', 2, 5, 2000, N'comment', N'ep:comment', N'mall/product/comment/index', N'ProductComment', 0, N'1', N'1', N'1', N'1', N'2023-08-26 11:03:00', N'1', N'2023-08-26 11:03:38', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2337, N'璇勮鏌ヨ', N'product:comment:query', 3, 1, 2336, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-26 11:04:01', N'1', N'2023-08-26 11:04:01', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2338, N'娣诲姞鑷瘎', N'product:comment:create', 3, 2, 2336, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-26 11:04:23', N'1', N'2023-08-26 11:08:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2339, N'鍟嗗鍥炲', N'product:comment:update', 3, 3, 2336, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-26 11:04:37', N'1', N'2023-08-26 11:04:37', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2340, N'鏄鹃殣璇勮', N'product:comment:update', 3, 4, 2336, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-08-26 11:04:55', N'1', N'2023-08-26 11:04:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2341, N'浼樻儬鍔靛彂閫?, N'promotion:coupon:send', 3, 2, 2038, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-09-02 00:03:14', N'1', N'2023-09-02 00:03:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2342, N'浜ゆ槗閰嶇疆', N'', 2, 0, 2072, N'config', N'ep:setting', N'mall/trade/config/index', N'TradeConfig', 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'1', N'2024-02-26 20:30:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2343, N'浜ゆ槗涓績閰嶇疆鏌ヨ', N'trade:config:query', 3, 1, 2342, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'', N'2023-09-28 02:46:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2344, N'浜ゆ槗涓績閰嶇疆淇濆瓨', N'trade:config:save', 3, 2, 2342, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'', N'2023-09-28 02:46:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2345, N'鍒嗛攢绠＄悊', N'', 1, 4, 2072, N'brokerage', N'fa-solid:project-diagram', N'', N'', 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'1', N'2023-09-28 10:58:44', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2346, N'鍒嗛攢鐢ㄦ埛', N'', 2, 0, 2345, N'brokerage-user', N'fa-solid:user-tie', N'mall/trade/brokerage/user/index', N'TradeBrokerageUser', 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'1', N'2024-02-26 20:33:23', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2347, N'鍒嗛攢鐢ㄦ埛鏌ヨ', N'trade:brokerage-user:query', 3, 1, 2346, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'', N'2023-09-28 02:46:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2348, N'鍒嗛攢鐢ㄦ埛鎺ㄥ箍浜烘煡璇?, N'trade:brokerage-user:user-query', 3, 2, 2346, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'', N'2023-09-28 02:46:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2349, N'鍒嗛攢鐢ㄦ埛鎺ㄥ箍璁㈠崟鏌ヨ', N'trade:brokerage-user:order-query', 3, 3, 2346, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'', N'2023-09-28 02:46:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2350, N'鍒嗛攢鐢ㄦ埛淇敼鎺ㄥ箍璧勬牸', N'trade:brokerage-user:update-brokerage-enable', 3, 4, 2346, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'', N'2023-09-28 02:46:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2351, N'淇敼鎺ㄥ箍鍛?, N'trade:brokerage-user:update-bind-user', 3, 5, 2346, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'1', N'2024-12-01 14:33:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2352, N'娓呴櫎鎺ㄥ箍鍛?, N'trade:brokerage-user:clear-bind-user', 3, 6, 2346, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'1', N'2024-12-01 14:33:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2353, N'浣ｉ噾璁板綍', N'', 2, 1, 2345, N'brokerage-record', N'fa:money', N'mall/trade/brokerage/record/index', N'TradeBrokerageRecord', 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'1', N'2024-02-26 20:33:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2354, N'浣ｉ噾璁板綍鏌ヨ', N'trade:brokerage-record:query', 3, 1, 2353, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'', N'2023-09-28 02:46:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2355, N'浣ｉ噾鎻愮幇', N'', 2, 2, 2345, N'brokerage-withdraw', N'fa:credit-card', N'mall/trade/brokerage/withdraw/index', N'TradeBrokerageWithdraw', 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'1', N'2024-02-26 20:33:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2356, N'浣ｉ噾鎻愮幇鏌ヨ', N'trade:brokerage-withdraw:query', 3, 1, 2355, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'', N'2023-09-28 02:46:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2357, N'浣ｉ噾鎻愮幇瀹℃牳', N'trade:brokerage-withdraw:audit', 3, 2, 2355, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-09-28 02:46:22', N'', N'2023-09-28 02:46:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2358, N'缁熻涓績', N'', 1, 75, 2362, N'statistics', N'ep:data-line', N'', N'', 0, N'1', N'1', N'1', N'', N'2023-09-30 03:22:40', N'1', N'2023-09-30 11:54:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2359, N'浜ゆ槗缁熻', N'', 2, 4, 2358, N'trade', N'fa-solid:credit-card', N'mall/statistics/trade/index', N'TradeStatistics', 0, N'1', N'1', N'1', N'', N'2023-09-30 03:22:40', N'1', N'2024-02-26 20:42:00', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2360, N'浜ゆ槗缁熻鏌ヨ', N'statistics:trade:query', 3, 1, 2359, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-09-30 03:22:40', N'', N'2023-09-30 03:22:40', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2361, N'浜ゆ槗缁熻瀵煎嚭', N'statistics:trade:export', 3, 2, 2359, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-09-30 03:22:40', N'', N'2023-09-30 03:22:40', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2362, N'鍟嗗煄绯荤粺', N'', 1, 59, 0, N'/mall', N'ep:shop', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-09-30 11:52:02', N'1', N'2023-09-30 11:52:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2363, N'鐢ㄦ埛绉垎淇敼', N'member:user:update-point', 3, 6, 2317, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-01 14:39:43', N'', N'2023-10-01 14:39:43', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2364, N'鐢ㄦ埛浣欓淇敼', N'pay:wallet:update-balance', 3, 7, 2317, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2023-10-01 14:39:43', N'1', N'2024-10-01 09:42:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2365, N'浼樻儬鍔?, N'', 1, 2, 2030, N'coupon', N'fa-solid:disease', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-10-03 12:39:15', N'1', N'2023-10-05 00:16:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2366, N'鐮嶄环璁板綍', N'', 2, 2, 2310, N'record', N'ep:list', N'mall/promotion/bargain/record/index', N'PromotionBargainRecord', 0, N'1', N'1', N'1', N'', N'2023-10-05 02:49:06', N'1', N'2023-10-05 10:50:38', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2367, N'鐮嶄环璁板綍鏌ヨ', N'promotion:bargain-record:query', 3, 1, 2366, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-05 02:49:06', N'', N'2023-10-05 02:49:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2368, N'鍔╁姏璁板綍鏌ヨ', N'promotion:bargain-help:query', 3, 2, 2366, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-10-05 12:27:49', N'1', N'2023-10-05 12:27:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2369, N'鎷煎洟璁板綍', N'promotion:combination-record:query', 2, 2, 2303, N'record', N'ep:avatar', N'mall/promotion/combination/record/index.vue', N'PromotionCombinationRecord', 0, N'1', N'1', N'1', N'1', N'2023-10-08 07:10:22', N'1', N'2023-10-08 07:34:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2374, N'浼氬憳缁熻', N'', 2, 2, 2358, N'member', N'ep:avatar', N'mall/statistics/member/index', N'MemberStatistics', 0, N'1', N'1', N'1', N'', N'2023-10-11 04:39:24', N'1', N'2024-02-26 20:41:46', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2375, N'浼氬憳缁熻鏌ヨ', N'statistics:member:query', 3, 1, 2374, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-11 04:39:24', N'', N'2023-10-11 04:39:24', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2376, N'璁㈠崟鏍搁攢', N'trade:order:pick-up', 3, 10, 2076, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-10-14 17:11:58', N'1', N'2023-10-14 17:11:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2377, N'鏂囩珷鍒嗙被', N'', 2, 0, 2387, N'article/category', N'fa:certificate', N'mall/promotion/article/category/index', N'ArticleCategory', 0, N'1', N'1', N'1', N'', N'2023-10-16 01:26:18', N'1', N'2023-10-16 09:38:26', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2378, N'鍒嗙被鏌ヨ', N'promotion:article-category:query', 3, 1, 2377, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-16 01:26:18', N'', N'2023-10-16 01:26:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2379, N'鍒嗙被鍒涘缓', N'promotion:article-category:create', 3, 2, 2377, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-16 01:26:18', N'', N'2023-10-16 01:26:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2380, N'鍒嗙被鏇存柊', N'promotion:article-category:update', 3, 3, 2377, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-16 01:26:18', N'', N'2023-10-16 01:26:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2381, N'鍒嗙被鍒犻櫎', N'promotion:article-category:delete', 3, 4, 2377, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-16 01:26:18', N'', N'2023-10-16 01:26:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2382, N'鏂囩珷鍒楄〃', N'', 2, 2, 2387, N'article', N'ep:connection', N'mall/promotion/article/index', N'Article', 0, N'1', N'1', N'1', N'', N'2023-10-16 01:26:18', N'1', N'2023-10-16 09:41:19', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2383, N'鏂囩珷绠＄悊鏌ヨ', N'promotion:article:query', 3, 1, 2382, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-16 01:26:18', N'', N'2023-10-16 01:26:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2384, N'鏂囩珷绠＄悊鍒涘缓', N'promotion:article:create', 3, 2, 2382, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-16 01:26:18', N'', N'2023-10-16 01:26:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2385, N'鏂囩珷绠＄悊鏇存柊', N'promotion:article:update', 3, 3, 2382, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-16 01:26:18', N'', N'2023-10-16 01:26:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2386, N'鏂囩珷绠＄悊鍒犻櫎', N'promotion:article:delete', 3, 4, 2382, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-16 01:26:18', N'', N'2023-10-16 01:26:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2387, N'鍐呭绠＄悊', N'', 1, 1, 2030, N'content', N'ep:collection', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-10-16 09:37:31', N'1', N'2023-10-16 09:37:31', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2388, N'鍟嗗煄棣栭〉', N'', 2, 1, 2362, N'home', N'ep:home-filled', N'mall/home/index', N'MallHome', 0, N'1', N'1', N'1', N'', N'2023-10-16 12:10:33', N'', N'2023-10-16 12:10:33', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2389, N'鏍搁攢璁㈠崟', N'', 2, 2, 2166, N'pick-up-order', N'ep:list', N'mall/trade/delivery/pickUpOrder/index', N'PickUpOrder', 0, N'1', N'1', N'1', N'', N'2023-10-19 16:09:51', N'', N'2023-10-19 16:09:51', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2390, N'浼樻儬娲诲姩', N'', 1, 99, 2030, N'youhui', N'ep:aim', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-10-21 19:23:49', N'1', N'2023-10-21 19:23:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2391, N'瀹㈡埛绠＄悊', N'', 2, 10, 2397, N'customer', N'fa:address-book-o', N'crm/customer/index', N'CrmCustomer', 0, N'1', N'1', N'1', N'', N'2023-10-29 09:04:21', N'1', N'2024-02-17 17:13:32', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2392, N'瀹㈡埛鏌ヨ', N'crm:customer:query', 3, 1, 2391, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 09:04:21', N'', N'2023-10-29 09:04:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2393, N'瀹㈡埛鍒涘缓', N'crm:customer:create', 3, 2, 2391, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 09:04:21', N'', N'2023-10-29 09:04:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2394, N'瀹㈡埛鏇存柊', N'crm:customer:update', 3, 3, 2391, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 09:04:21', N'', N'2023-10-29 09:04:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2395, N'瀹㈡埛鍒犻櫎', N'crm:customer:delete', 3, 4, 2391, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 09:04:21', N'', N'2023-10-29 09:04:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2396, N'瀹㈡埛瀵煎嚭', N'crm:customer:export', 3, 5, 2391, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 09:04:21', N'', N'2023-10-29 09:04:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2397, N'CRM 绯荤粺', N'', 1, 200, 0, N'/crm', N'simple-icons:civicrm', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-10-29 17:08:30', N'1', N'2025-04-19 18:56:38', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2398, N'鍚堝悓绠＄悊', N'', 2, 50, 2397, N'contract', N'ep:notebook', N'crm/contract/index', N'CrmContract', 0, N'1', N'1', N'1', N'', N'2023-10-29 10:50:41', N'1', N'2024-02-17 17:15:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2399, N'鍚堝悓鏌ヨ', N'crm:contract:query', 3, 1, 2398, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 10:50:41', N'', N'2023-10-29 10:50:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2400, N'鍚堝悓鍒涘缓', N'crm:contract:create', 3, 2, 2398, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 10:50:41', N'', N'2023-10-29 10:50:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2401, N'鍚堝悓鏇存柊', N'crm:contract:update', 3, 3, 2398, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 10:50:41', N'', N'2023-10-29 10:50:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2402, N'鍚堝悓鍒犻櫎', N'crm:contract:delete', 3, 4, 2398, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 10:50:41', N'', N'2023-10-29 10:50:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2403, N'鍚堝悓瀵煎嚭', N'crm:contract:export', 3, 5, 2398, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 10:50:41', N'', N'2023-10-29 10:50:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2404, N'绾跨储绠＄悊', N'', 2, 8, 2397, N'clue', N'fa:pagelines', N'crm/clue/index', N'CrmClue', 0, N'1', N'1', N'1', N'', N'2023-10-29 11:06:29', N'1', N'2024-02-17 17:15:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2405, N'绾跨储鏌ヨ', N'crm:clue:query', 3, 1, 2404, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:06:29', N'', N'2023-10-29 11:06:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2406, N'绾跨储鍒涘缓', N'crm:clue:create', 3, 2, 2404, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:06:29', N'', N'2023-10-29 11:06:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2407, N'绾跨储鏇存柊', N'crm:clue:update', 3, 3, 2404, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:06:29', N'', N'2023-10-29 11:06:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2408, N'绾跨储鍒犻櫎', N'crm:clue:delete', 3, 4, 2404, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:06:29', N'', N'2023-10-29 11:06:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2409, N'绾跨储瀵煎嚭', N'crm:clue:export', 3, 5, 2404, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:06:29', N'', N'2023-10-29 11:06:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2410, N'鍟嗘満绠＄悊', N'', 2, 40, 2397, N'business', N'fa:bus', N'crm/business/index', N'CrmBusiness', 0, N'1', N'1', N'1', N'', N'2023-10-29 11:12:35', N'1', N'2024-02-17 17:14:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2411, N'鍟嗘満鏌ヨ', N'crm:business:query', 3, 1, 2410, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:12:35', N'', N'2023-10-29 11:12:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2412, N'鍟嗘満鍒涘缓', N'crm:business:create', 3, 2, 2410, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:12:35', N'', N'2023-10-29 11:12:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2413, N'鍟嗘満鏇存柊', N'crm:business:update', 3, 3, 2410, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:12:35', N'', N'2023-10-29 11:12:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2414, N'鍟嗘満鍒犻櫎', N'crm:business:delete', 3, 4, 2410, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:12:35', N'', N'2023-10-29 11:12:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2415, N'鍟嗘満瀵煎嚭', N'crm:business:export', 3, 5, 2410, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:12:35', N'', N'2023-10-29 11:12:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2416, N'鑱旂郴浜虹鐞?, N'', 2, 20, 2397, N'contact', N'fa:address-book-o', N'crm/contact/index', N'CrmContact', 0, N'1', N'1', N'1', N'', N'2023-10-29 11:14:56', N'1', N'2024-02-17 17:13:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2417, N'鑱旂郴浜烘煡璇?, N'crm:contact:query', 3, 1, 2416, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:14:56', N'', N'2023-10-29 11:14:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2418, N'鑱旂郴浜哄垱寤?, N'crm:contact:create', 3, 2, 2416, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:14:56', N'', N'2023-10-29 11:14:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2419, N'鑱旂郴浜烘洿鏂?, N'crm:contact:update', 3, 3, 2416, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:14:56', N'', N'2023-10-29 11:14:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2420, N'鑱旂郴浜哄垹闄?, N'crm:contact:delete', 3, 4, 2416, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:14:56', N'', N'2023-10-29 11:14:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2421, N'鑱旂郴浜哄鍑?, N'crm:contact:export', 3, 5, 2416, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:14:56', N'', N'2023-10-29 11:14:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2422, N'鍥炴绠＄悊', N'', 2, 60, 2397, N'receivable', N'ep:money', N'crm/receivable/index', N'CrmReceivable', 0, N'1', N'1', N'1', N'', N'2023-10-29 11:18:09', N'1', N'2024-02-17 17:16:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2423, N'鍥炴绠＄悊鏌ヨ', N'crm:receivable:query', 3, 1, 2422, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:18:09', N'', N'2023-10-29 11:18:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2424, N'鍥炴绠＄悊鍒涘缓', N'crm:receivable:create', 3, 2, 2422, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:18:09', N'', N'2023-10-29 11:18:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2425, N'鍥炴绠＄悊鏇存柊', N'crm:receivable:update', 3, 3, 2422, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:18:09', N'', N'2023-10-29 11:18:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2426, N'鍥炴绠＄悊鍒犻櫎', N'crm:receivable:delete', 3, 4, 2422, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:18:09', N'', N'2023-10-29 11:18:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2427, N'鍥炴绠＄悊瀵煎嚭', N'crm:receivable:export', 3, 5, 2422, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:18:09', N'', N'2023-10-29 11:18:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2428, N'鍥炴璁″垝', N'', 2, 61, 2397, N'receivable-plan', N'fa:money', N'crm/receivable/plan/index', N'CrmReceivablePlan', 0, N'1', N'1', N'1', N'', N'2023-10-29 11:18:09', N'1', N'2024-02-17 17:16:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2429, N'鍥炴璁″垝鏌ヨ', N'crm:receivable-plan:query', 3, 1, 2428, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:18:09', N'', N'2023-10-29 11:18:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2430, N'鍥炴璁″垝鍒涘缓', N'crm:receivable-plan:create', 3, 2, 2428, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:18:09', N'', N'2023-10-29 11:18:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2431, N'鍥炴璁″垝鏇存柊', N'crm:receivable-plan:update', 3, 3, 2428, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:18:09', N'', N'2023-10-29 11:18:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2432, N'鍥炴璁″垝鍒犻櫎', N'crm:receivable-plan:delete', 3, 4, 2428, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:18:09', N'', N'2023-10-29 11:18:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2433, N'鍥炴璁″垝瀵煎嚭', N'crm:receivable-plan:export', 3, 5, 2428, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 11:18:09', N'', N'2023-10-29 11:18:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2435, N'鍟嗗煄瑁呬慨', N'', 2, 20, 2030, N'diy-template', N'fa6-solid:brush', N'mall/promotion/diy/template/index', N'', 0, N'1', N'1', N'1', N'', N'2023-10-29 14:19:25', N'1', N'2025-03-15 21:34:33', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2436, N'瑁呬慨妯℃澘', N'', 2, 1, 2435, N'diy-template', N'fa6-solid:brush', N'mall/promotion/diy/template/index', N'DiyTemplate', 0, N'1', N'1', N'1', N'', N'2023-10-29 14:19:25', N'', N'2023-10-29 14:19:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2437, N'瑁呬慨妯℃澘鏌ヨ', N'promotion:diy-template:query', 3, 1, 2436, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 14:19:25', N'', N'2023-10-29 14:19:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2438, N'瑁呬慨妯℃澘鍒涘缓', N'promotion:diy-template:create', 3, 2, 2436, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 14:19:25', N'', N'2023-10-29 14:19:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2439, N'瑁呬慨妯℃澘鏇存柊', N'promotion:diy-template:update', 3, 3, 2436, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 14:19:25', N'', N'2023-10-29 14:19:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2440, N'瑁呬慨妯℃澘鍒犻櫎', N'promotion:diy-template:delete', 3, 4, 2436, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 14:19:25', N'', N'2023-10-29 14:19:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2441, N'瑁呬慨妯℃澘浣跨敤', N'promotion:diy-template:use', 3, 5, 2436, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 14:19:25', N'', N'2023-10-29 14:19:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2442, N'瑁呬慨椤甸潰', N'', 2, 2, 2435, N'diy-page', N'foundation:page-edit', N'mall/promotion/diy/page/index', N'DiyPage', 0, N'1', N'1', N'1', N'', N'2023-10-29 14:19:25', N'', N'2023-10-29 14:19:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2443, N'瑁呬慨椤甸潰鏌ヨ', N'promotion:diy-page:query', 3, 1, 2442, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 14:19:25', N'', N'2023-10-29 14:19:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2444, N'瑁呬慨椤甸潰鍒涘缓', N'promotion:diy-page:create', 3, 2, 2442, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 14:19:26', N'', N'2023-10-29 14:19:26', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2445, N'瑁呬慨椤甸潰鏇存柊', N'promotion:diy-page:update', 3, 3, 2442, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 14:19:26', N'', N'2023-10-29 14:19:26', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2446, N'瑁呬慨椤甸潰鍒犻櫎', N'promotion:diy-page:delete', 3, 4, 2442, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-10-29 14:19:26', N'', N'2023-10-29 14:19:26', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2447, N'涓夋柟鐧诲綍', N'', 1, 10, 1, N'social', N'fa:rocket', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-11-04 12:12:01', N'1', N'2024-02-29 01:14:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2448, N'涓夋柟搴旂敤', N'', 2, 1, 2447, N'client', N'ep:set-up', N'system/social/client/index.vue', N'SocialClient', 0, N'1', N'1', N'1', N'1', N'2023-11-04 12:17:19', N'1', N'2024-05-04 19:09:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2449, N'涓夋柟搴旂敤鏌ヨ', N'system:social-client:query', 3, 1, 2448, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-11-04 12:43:12', N'1', N'2023-11-04 12:43:33', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2450, N'涓夋柟搴旂敤鍒涘缓', N'system:social-client:create', 3, 2, 2448, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-11-04 12:43:58', N'1', N'2023-11-04 12:43:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2451, N'涓夋柟搴旂敤鏇存柊', N'system:social-client:update', 3, 3, 2448, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-11-04 12:44:27', N'1', N'2023-11-04 12:44:27', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2452, N'涓夋柟搴旂敤鍒犻櫎', N'system:social-client:delete', 3, 4, 2448, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-11-04 12:44:43', N'1', N'2023-11-04 12:44:43', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2453, N'涓夋柟鐢ㄦ埛', N'system:social-user:query', 2, 2, 2447, N'user', N'ep:avatar', N'system/social/user/index.vue', N'SocialUser', 0, N'1', N'1', N'1', N'1', N'2023-11-04 14:01:05', N'1', N'2023-11-04 14:01:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2472, N'涓诲瓙琛紙鍐呭祵锛?, N'', 2, 12, 1070, N'demo03-inner', N'fa:power-off', N'infra/demo/demo03/inner/index', N'Demo03StudentInner', 0, N'1', N'1', N'1', N'', N'2023-11-13 04:39:51', N'1', N'2023-11-16 23:53:46', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2478, N'鍗曡〃锛堝鍒犳敼鏌ワ級', N'', 2, 1, 1070, N'demo01-contact', N'ep:bicycle', N'infra/demo/demo01/index', N'Demo01Contact', 0, N'1', N'1', N'1', N'', N'2023-11-15 14:42:30', N'1', N'2023-11-16 20:34:40', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2479, N'绀轰緥鑱旂郴浜烘煡璇?, N'infra:demo01-contact:query', 3, 1, 2478, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-15 14:42:30', N'', N'2023-11-15 14:42:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2480, N'绀轰緥鑱旂郴浜哄垱寤?, N'infra:demo01-contact:create', 3, 2, 2478, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-15 14:42:30', N'', N'2023-11-15 14:42:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2481, N'绀轰緥鑱旂郴浜烘洿鏂?, N'infra:demo01-contact:update', 3, 3, 2478, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-15 14:42:30', N'', N'2023-11-15 14:42:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2482, N'绀轰緥鑱旂郴浜哄垹闄?, N'infra:demo01-contact:delete', 3, 4, 2478, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-15 14:42:30', N'', N'2023-11-15 14:42:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2483, N'绀轰緥鑱旂郴浜哄鍑?, N'infra:demo01-contact:export', 3, 5, 2478, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-15 14:42:30', N'', N'2023-11-15 14:42:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2484, N'鏍戣〃锛堝鍒犳敼鏌ワ級', N'', 2, 2, 1070, N'demo02-category', N'fa:tree', N'infra/demo/demo02/index', N'Demo02Category', 0, N'1', N'1', N'1', N'', N'2023-11-16 12:18:27', N'1', N'2023-11-16 20:35:01', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2485, N'绀轰緥鍒嗙被鏌ヨ', N'infra:demo02-category:query', 3, 1, 2484, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-16 12:18:27', N'', N'2023-11-16 12:18:27', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2486, N'绀轰緥鍒嗙被鍒涘缓', N'infra:demo02-category:create', 3, 2, 2484, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-16 12:18:27', N'', N'2023-11-16 12:18:27', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2487, N'绀轰緥鍒嗙被鏇存柊', N'infra:demo02-category:update', 3, 3, 2484, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-16 12:18:27', N'', N'2023-11-16 12:18:27', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2488, N'绀轰緥鍒嗙被鍒犻櫎', N'infra:demo02-category:delete', 3, 4, 2484, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-16 12:18:27', N'', N'2023-11-16 12:18:27', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2489, N'绀轰緥鍒嗙被瀵煎嚭', N'infra:demo02-category:export', 3, 5, 2484, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-16 12:18:27', N'', N'2023-11-16 12:18:27', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2490, N'涓诲瓙琛紙鏍囧噯锛?, N'', 2, 10, 1070, N'demo03-normal', N'fa:battery-3', N'infra/demo/demo03/normal/index', N'Demo03StudentNormal', 0, N'1', N'1', N'1', N'', N'2023-11-16 12:53:37', N'1', N'2023-11-16 23:10:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2491, N'瀛︾敓鏌ヨ', N'infra:demo03-student:query', 3, 1, 2490, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-16 12:53:37', N'', N'2023-11-16 12:53:37', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2492, N'瀛︾敓鍒涘缓', N'infra:demo03-student:create', 3, 2, 2490, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-16 12:53:37', N'', N'2023-11-16 12:53:37', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2493, N'瀛︾敓鏇存柊', N'infra:demo03-student:update', 3, 3, 2490, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-16 12:53:37', N'', N'2023-11-16 12:53:37', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2494, N'瀛︾敓鍒犻櫎', N'infra:demo03-student:delete', 3, 4, 2490, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-16 12:53:37', N'', N'2023-11-16 12:53:37', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2495, N'瀛︾敓瀵煎嚭', N'infra:demo03-student:export', 3, 5, 2490, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-16 12:53:37', N'', N'2023-11-16 12:53:37', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2497, N'涓诲瓙琛紙ERP锛?, N'', 2, 11, 1070, N'demo03-erp', N'ep:calendar', N'infra/demo/demo03/erp/index', N'Demo03StudentERP', 0, N'1', N'1', N'1', N'', N'2023-11-16 15:50:59', N'1', N'2023-11-17 13:19:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2516, N'瀹㈡埛鍏捣閰嶇疆', N'', 2, 0, 2524, N'customer-pool-config', N'ep:data-analysis', N'crm/customer/poolConfig/index', N'CrmCustomerPoolConfig', 0, N'1', N'1', N'1', N'', N'2023-11-18 13:33:31', N'1', N'2024-01-03 19:52:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2517, N'瀹㈡埛鍏捣閰嶇疆淇濆瓨', N'crm:customer-pool-config:update', 3, 1, 2516, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-18 13:33:31', N'', N'2023-11-18 13:33:31', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2518, N'瀹㈡埛闄愬埗閰嶇疆', N'', 2, 1, 2524, N'customer-limit-config', N'ep:avatar', N'crm/customer/limitConfig/index', N'CrmCustomerLimitConfig', 0, N'1', N'1', N'1', N'', N'2023-11-18 13:33:53', N'1', N'2024-02-24 16:43:33', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2519, N'瀹㈡埛闄愬埗閰嶇疆鏌ヨ', N'crm:customer-limit-config:query', 3, 1, 2518, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-18 13:33:53', N'', N'2023-11-18 13:33:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2520, N'瀹㈡埛闄愬埗閰嶇疆鍒涘缓', N'crm:customer-limit-config:create', 3, 2, 2518, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-18 13:33:53', N'', N'2023-11-18 13:33:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2521, N'瀹㈡埛闄愬埗閰嶇疆鏇存柊', N'crm:customer-limit-config:update', 3, 3, 2518, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-18 13:33:53', N'', N'2023-11-18 13:33:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2522, N'瀹㈡埛闄愬埗閰嶇疆鍒犻櫎', N'crm:customer-limit-config:delete', 3, 4, 2518, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-18 13:33:53', N'', N'2023-11-18 13:33:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2523, N'瀹㈡埛闄愬埗閰嶇疆瀵煎嚭', N'crm:customer-limit-config:export', 3, 5, 2518, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-11-18 13:33:53', N'', N'2023-11-18 13:33:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2524, N'绯荤粺閰嶇疆', N'', 1, 999, 2397, N'config', N'ep:connection', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-11-18 21:58:00', N'1', N'2024-02-17 17:14:34', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2525, N'WebSocket', N'', 2, 5, 2, N'websocket', N'ep:connection', N'infra/webSocket/index', N'InfraWebSocket', 0, N'1', N'1', N'1', N'1', N'2023-11-23 19:41:55', N'1', N'2024-04-23 00:02:00', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2526, N'浜у搧绠＄悊', N'', 2, 80, 2397, N'product', N'fa:product-hunt', N'crm/product/index', N'CrmProduct', 0, N'1', N'1', N'1', N'1', N'2023-12-05 22:45:26', N'1', N'2024-02-20 20:36:20', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2527, N'浜у搧鏌ヨ', N'crm:product:query', 3, 1, 2526, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-12-05 22:47:16', N'1', N'2023-12-05 22:47:16', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2528, N'浜у搧鍒涘缓', N'crm:product:create', 3, 2, 2526, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-12-05 22:47:41', N'1', N'2023-12-05 22:47:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2529, N'浜у搧鏇存柊', N'crm:product:update', 3, 3, 2526, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-12-05 22:48:03', N'1', N'2023-12-05 22:48:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2530, N'浜у搧鍒犻櫎', N'crm:product:delete', 3, 4, 2526, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-12-05 22:48:17', N'1', N'2023-12-05 22:48:17', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2531, N'浜у搧瀵煎嚭', N'crm:product:export', 3, 5, 2526, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-12-05 22:48:29', N'1', N'2023-12-05 22:48:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2532, N'浜у搧鍒嗙被閰嶇疆', N'', 2, 3, 2524, N'product/category', N'fa-solid:window-restore', N'crm/product/category/index', N'CrmProductCategory', 0, N'1', N'1', N'1', N'1', N'2023-12-06 12:52:36', N'1', N'2023-12-06 12:52:51', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2533, N'浜у搧鍒嗙被鏌ヨ', N'crm:product-category:query', 3, 1, 2532, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-12-06 12:53:23', N'1', N'2023-12-06 12:53:23', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2534, N'浜у搧鍒嗙被鍒涘缓', N'crm:product-category:create', 3, 2, 2532, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-12-06 12:53:41', N'1', N'2023-12-06 12:53:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2535, N'浜у搧鍒嗙被鏇存柊', N'crm:product-category:update', 3, 3, 2532, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-12-06 12:53:59', N'1', N'2023-12-06 12:53:59', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2536, N'浜у搧鍒嗙被鍒犻櫎', N'crm:product-category:delete', 3, 4, 2532, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2023-12-06 12:54:14', N'1', N'2023-12-06 12:54:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2543, N'鍏宠仈鍟嗘満', N'crm:contact:create-business', 3, 10, 2416, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-01-02 17:28:25', N'1', N'2024-01-02 17:28:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2544, N'鍙栧叧鍟嗘満', N'crm:contact:delete-business', 3, 11, 2416, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-01-02 17:28:43', N'1', N'2024-01-02 17:28:51', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2545, N'鍟嗗搧缁熻', N'', 2, 3, 2358, N'product', N'fa:product-hunt', N'mall/statistics/product/index', N'ProductStatistics', 0, N'1', N'1', N'1', N'', N'2023-12-15 18:54:28', N'1', N'2024-02-26 20:41:52', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2546, N'瀹㈡埛鍏捣', N'', 2, 30, 2397, N'customer/pool', N'fa-solid:swimming-pool', N'crm/customer/pool/index', N'CrmCustomerPool', 0, N'1', N'1', N'1', N'1', N'2024-01-15 21:29:34', N'1', N'2024-02-17 17:14:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2547, N'璁㈠崟鏌ヨ', N'trade:order:query', 3, 1, 2076, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-01-16 08:52:00', N'1', N'2024-01-16 08:52:00', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2548, N'璁㈠崟鏇存柊', N'trade:order:update', 3, 2, 2076, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-01-16 08:52:21', N'1', N'2024-01-16 08:52:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2549, N'鏀粯&閫€娆炬渚?, N'', 2, 1, 2161, N'order', N'fa:paypal', N'pay/demo/order/index', N'', 0, N'1', N'1', N'1', N'1', N'2024-01-18 23:45:00', N'1', N'2024-01-18 23:47:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2550, N'鎻愮幇杞处妗堜緥', N'', 2, 2, 2161, N'transfer', N'fa:transgender-alt', N'pay/demo/withdraw/index', N'', 0, N'1', N'1', N'1', N'1', N'2024-01-18 23:51:16', N'1', N'2025-05-08 13:04:36', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2551, N'閽卞寘绠＄悊', N'', 1, 4, 1117, N'wallet', N'ep:wallet', N'', N'', 0, N'1', N'1', N'1', N'', N'2023-12-29 02:32:54', N'1', N'2024-02-29 08:58:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2552, N'鍏呭€煎椁?, N'', 2, 2, 2551, N'wallet-recharge-package', N'fa:leaf', N'pay/wallet/rechargePackage/index', N'WalletRechargePackage', 0, N'1', N'1', N'1', N'', N'2023-12-29 02:32:54', N'', N'2023-12-29 02:32:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2553, N'閽卞寘鍏呭€煎椁愭煡璇?, N'pay:wallet-recharge-package:query', 3, 1, 2552, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-12-29 02:32:54', N'', N'2023-12-29 02:32:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2554, N'閽卞寘鍏呭€煎椁愬垱寤?, N'pay:wallet-recharge-package:create', 3, 2, 2552, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-12-29 02:32:54', N'', N'2023-12-29 02:32:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2555, N'閽卞寘鍏呭€煎椁愭洿鏂?, N'pay:wallet-recharge-package:update', 3, 3, 2552, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-12-29 02:32:54', N'', N'2023-12-29 02:32:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2556, N'閽卞寘鍏呭€煎椁愬垹闄?, N'pay:wallet-recharge-package:delete', 3, 4, 2552, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-12-29 02:32:54', N'', N'2023-12-29 02:32:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2557, N'閽卞寘浣欓', N'', 2, 1, 2551, N'wallet-balance', N'fa:leaf', N'pay/wallet/balance/index', N'WalletBalance', 0, N'1', N'1', N'1', N'', N'2023-12-29 02:32:54', N'', N'2023-12-29 02:32:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2558, N'閽卞寘浣欓鏌ヨ', N'pay:wallet:query', 3, 1, 2557, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2023-12-29 02:32:54', N'', N'2023-12-29 02:32:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2559, N'杞处璁㈠崟', N'', 2, 3, 1117, N'transfer', N'ep:credit-card', N'pay/transfer/index', N'PayTransfer', 0, N'1', N'1', N'1', N'', N'2023-12-29 02:32:54', N'', N'2023-12-29 02:32:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2560, N'鏁版嵁缁熻', N'', 1, 200, 2397, N'statistics', N'ep:data-line', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-01-26 22:50:35', N'1', N'2024-02-24 20:10:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2561, N'鎺掕姒?, N'crm:statistics-rank:query', 2, 1, 2560, N'ranking', N'fa:area-chart', N'crm/statistics/rank/index', N'CrmStatisticsRank', 0, N'1', N'1', N'1', N'1', N'2024-01-26 22:52:09', N'1', N'2024-04-24 19:39:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2562, N'瀹㈡埛瀵煎叆', N'crm:customer:import', 3, 6, 2391, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-01 13:09:00', N'1', N'2024-02-01 13:09:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2563, N'ERP 绯荤粺', N'', 1, 300, 0, N'/erp', N'simple-icons:erpnext', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-04 15:37:25', N'1', N'2025-04-19 18:56:15', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2564, N'浜у搧绠＄悊', N'', 1, 40, 2563, N'product', N'fa:product-hunt', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-04 15:38:43', N'1', N'2024-02-04 15:38:43', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2565, N'浜у搧淇℃伅', N'', 2, 0, 2564, N'product', N'fa-solid:apple-alt', N'erp/product/product/index', N'ErpProduct', 0, N'1', N'1', N'1', N'', N'2024-02-04 07:52:15', N'1', N'2024-02-05 14:42:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2566, N'浜у搧鏌ヨ', N'erp:product:query', 3, 1, 2565, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-02-04 07:52:15', N'1', N'2024-02-04 17:21:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2567, N'浜у搧鍒涘缓', N'erp:product:create', 3, 2, 2565, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-02-04 07:52:15', N'1', N'2024-02-04 17:22:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2568, N'浜у搧鏇存柊', N'erp:product:update', 3, 3, 2565, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-02-04 07:52:15', N'1', N'2024-02-04 17:22:16', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2569, N'浜у搧鍒犻櫎', N'erp:product:delete', 3, 4, 2565, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-02-04 07:52:15', N'1', N'2024-02-04 17:22:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2570, N'浜у搧瀵煎嚭', N'erp:product:export', 3, 5, 2565, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-02-04 07:52:15', N'1', N'2024-02-04 17:22:26', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2571, N'浜у搧鍒嗙被', N'', 2, 1, 2564, N'product-category', N'fa:certificate', N'erp/product/category/index', N'ErpProductCategory', 0, N'1', N'1', N'1', N'', N'2024-02-04 09:21:04', N'1', N'2024-02-04 17:24:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2572, N'鍒嗙被鏌ヨ', N'erp:product-category:query', 3, 1, 2571, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 09:21:04', N'', N'2024-02-04 09:21:04', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2573, N'鍒嗙被鍒涘缓', N'erp:product-category:create', 3, 2, 2571, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 09:21:04', N'', N'2024-02-04 09:21:04', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2574, N'鍒嗙被鏇存柊', N'erp:product-category:update', 3, 3, 2571, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 09:21:04', N'', N'2024-02-04 09:21:04', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2575, N'鍒嗙被鍒犻櫎', N'erp:product-category:delete', 3, 4, 2571, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 09:21:04', N'', N'2024-02-04 09:21:04', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2576, N'鍒嗙被瀵煎嚭', N'erp:product-category:export', 3, 5, 2571, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 09:21:04', N'', N'2024-02-04 09:21:04', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2577, N'浜у搧鍗曚綅', N'', 2, 2, 2564, N'unit', N'ep:opportunity', N'erp/product/unit/index', N'ErpProductUnit', 0, N'1', N'1', N'1', N'', N'2024-02-04 11:54:08', N'1', N'2024-02-04 19:54:37', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2578, N'鍗曚綅鏌ヨ', N'erp:product-unit:query', 3, 1, 2577, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 11:54:08', N'', N'2024-02-04 11:54:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2579, N'鍗曚綅鍒涘缓', N'erp:product-unit:create', 3, 2, 2577, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 11:54:08', N'', N'2024-02-04 11:54:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2580, N'鍗曚綅鏇存柊', N'erp:product-unit:update', 3, 3, 2577, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 11:54:08', N'', N'2024-02-04 11:54:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2581, N'鍗曚綅鍒犻櫎', N'erp:product-unit:delete', 3, 4, 2577, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 11:54:08', N'', N'2024-02-04 11:54:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2582, N'鍗曚綅瀵煎嚭', N'erp:product-unit:export', 3, 5, 2577, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 11:54:08', N'', N'2024-02-04 11:54:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2583, N'搴撳瓨绠＄悊', N'', 1, 30, 2563, N'stock', N'fa:window-restore', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-05 00:29:37', N'1', N'2024-02-05 00:29:37', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2584, N'浠撳簱淇℃伅', N'', 2, 0, 2583, N'warehouse', N'ep:house', N'erp/stock/warehouse/index', N'ErpWarehouse', 0, N'1', N'1', N'1', N'', N'2024-02-04 17:12:09', N'1', N'2024-02-05 01:12:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2585, N'浠撳簱鏌ヨ', N'erp:warehouse:query', 3, 1, 2584, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 17:12:09', N'', N'2024-02-04 17:12:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2586, N'浠撳簱鍒涘缓', N'erp:warehouse:create', 3, 2, 2584, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 17:12:09', N'', N'2024-02-04 17:12:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2587, N'浠撳簱鏇存柊', N'erp:warehouse:update', 3, 3, 2584, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 17:12:09', N'', N'2024-02-04 17:12:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2588, N'浠撳簱鍒犻櫎', N'erp:warehouse:delete', 3, 4, 2584, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 17:12:09', N'', N'2024-02-04 17:12:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2589, N'浠撳簱瀵煎嚭', N'erp:warehouse:export', 3, 5, 2584, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-04 17:12:09', N'', N'2024-02-04 17:12:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2590, N'浜у搧搴撳瓨', N'', 2, 1, 2583, N'stock', N'ep:coffee', N'erp/stock/stock/index', N'ErpStock', 0, N'1', N'1', N'1', N'', N'2024-02-05 06:40:50', N'1', N'2024-02-05 14:42:44', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2591, N'搴撳瓨鏌ヨ', N'erp:stock:query', 3, 1, 2590, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 06:40:50', N'', N'2024-02-05 06:40:50', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2592, N'搴撳瓨瀵煎嚭', N'erp:stock:export', 3, 5, 2590, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 06:40:50', N'', N'2024-02-05 06:40:50', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2593, N'鍑哄叆搴撴槑缁?, N'', 2, 2, 2583, N'record', N'fa-solid:blog', N'erp/stock/record/index', N'ErpStockRecord', 0, N'1', N'1', N'1', N'', N'2024-02-05 10:27:21', N'1', N'2024-02-06 17:26:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2594, N'搴撳瓨鏄庣粏鏌ヨ', N'erp:stock-record:query', 3, 1, 2593, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 10:27:21', N'', N'2024-02-05 10:27:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2595, N'搴撳瓨鏄庣粏瀵煎嚭', N'erp:stock-record:export', 3, 5, 2593, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 10:27:21', N'', N'2024-02-05 10:27:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2596, N'鍏跺畠鍏ュ簱', N'', 2, 3, 2583, N'in', N'ep:zoom-in', N'erp/stock/in/index', N'ErpStockIn', 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'1', N'2024-02-07 19:06:51', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2597, N'鍏跺畠鍏ュ簱鍗曟煡璇?, N'erp:stock-in:query', 3, 1, 2596, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-05 16:08:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2598, N'鍏跺畠鍏ュ簱鍗曞垱寤?, N'erp:stock-in:create', 3, 2, 2596, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-05 16:08:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2599, N'鍏跺畠鍏ュ簱鍗曟洿鏂?, N'erp:stock-in:update', 3, 3, 2596, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-05 16:08:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2600, N'鍏跺畠鍏ュ簱鍗曞垹闄?, N'erp:stock-in:delete', 3, 4, 2596, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-05 16:08:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2601, N'鍏跺畠鍏ュ簱鍗曞鍑?, N'erp:stock-in:export', 3, 5, 2596, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-05 16:08:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2602, N'閲囪喘绠＄悊', N'', 1, 10, 2563, N'purchase', N'fa:buysellads', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-06 16:01:01', N'1', N'2024-02-06 16:01:23', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2603, N'渚涘簲鍟嗕俊鎭?, N'', 2, 4, 2602, N'supplier', N'fa:superpowers', N'erp/purchase/supplier/index', N'ErpSupplier', 0, N'1', N'1', N'1', N'', N'2024-02-06 08:21:55', N'1', N'2024-02-06 16:22:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2604, N'渚涘簲鍟嗘煡璇?, N'erp:supplier:query', 3, 1, 2603, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-06 08:21:55', N'', N'2024-02-06 08:21:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2605, N'渚涘簲鍟嗗垱寤?, N'erp:supplier:create', 3, 2, 2603, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-06 08:21:55', N'', N'2024-02-06 08:21:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2606, N'渚涘簲鍟嗘洿鏂?, N'erp:supplier:update', 3, 3, 2603, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-06 08:21:55', N'', N'2024-02-06 08:21:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2607, N'渚涘簲鍟嗗垹闄?, N'erp:supplier:delete', 3, 4, 2603, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-06 08:21:55', N'', N'2024-02-06 08:21:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2608, N'渚涘簲鍟嗗鍑?, N'erp:supplier:export', 3, 5, 2603, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-06 08:21:55', N'', N'2024-02-06 08:21:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2609, N'鍏跺畠鍏ュ簱鍗曞鎵?, N'erp:stock-in:update-status', 3, 6, 2596, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-05 16:08:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2610, N'鍏跺畠鍑哄簱', N'', 2, 4, 2583, N'out', N'ep:zoom-out', N'erp/stock/out/index', N'ErpStockOut', 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'1', N'2024-02-07 19:06:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2611, N'鍏跺畠鍑哄簱鍗曟煡璇?, N'erp:stock-out:query', 3, 1, 2610, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 06:43:39', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2612, N'鍏跺畠鍑哄簱鍗曞垱寤?, N'erp:stock-out:create', 3, 2, 2610, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 06:43:42', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2613, N'鍏跺畠鍑哄簱鍗曟洿鏂?, N'erp:stock-out:update', 3, 3, 2610, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 06:43:44', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2614, N'鍏跺畠鍑哄簱鍗曞垹闄?, N'erp:stock-out:delete', 3, 4, 2610, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 06:43:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2615, N'鍏跺畠鍑哄簱鍗曞鍑?, N'erp:stock-out:export', 3, 5, 2610, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 06:43:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2616, N'鍏跺畠鍑哄簱鍗曞鎵?, N'erp:stock-out:update-status', 3, 6, 2610, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 06:43:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2617, N'閿€鍞鐞?, N'', 1, 20, 2563, N'sale', N'fa:sellsy', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-07 15:12:32', N'1', N'2024-02-07 15:12:32', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2618, N'瀹㈡埛淇℃伅', N'', 2, 4, 2617, N'customer', N'ep:avatar', N'erp/sale/customer/index', N'ErpCustomer', 0, N'1', N'1', N'1', N'', N'2024-02-07 07:21:45', N'1', N'2024-02-07 15:22:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2619, N'瀹㈡埛鏌ヨ', N'erp:customer:query', 3, 1, 2618, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-07 07:21:45', N'', N'2024-02-07 07:21:45', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2620, N'瀹㈡埛鍒涘缓', N'erp:customer:create', 3, 2, 2618, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-07 07:21:45', N'', N'2024-02-07 07:21:45', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2621, N'瀹㈡埛鏇存柊', N'erp:customer:update', 3, 3, 2618, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-07 07:21:45', N'', N'2024-02-07 07:21:45', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2622, N'瀹㈡埛鍒犻櫎', N'erp:customer:delete', 3, 4, 2618, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-07 07:21:45', N'', N'2024-02-07 07:21:45', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2623, N'瀹㈡埛瀵煎嚭', N'erp:customer:export', 3, 5, 2618, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-07 07:21:45', N'', N'2024-02-07 07:21:45', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2624, N'搴撳瓨璋冩嫧', N'', 2, 5, 2583, N'move', N'ep:folder-remove', N'erp/stock/move/index', N'ErpStockMove', 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'1', N'2024-02-16 18:53:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2625, N'搴撳瓨璋冨害鍗曟煡璇?, N'erp:stock-move:query', 3, 1, 2624, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2626, N'搴撳瓨璋冨害鍗曞垱寤?, N'erp:stock-move:create', 3, 2, 2624, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:52', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2627, N'搴撳瓨璋冨害鍗曟洿鏂?, N'erp:stock-move:update', 3, 3, 2624, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2628, N'搴撳瓨璋冨害鍗曞垹闄?, N'erp:stock-move:delete', 3, 4, 2624, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2629, N'搴撳瓨璋冨害鍗曞鍑?, N'erp:stock-move:export', 3, 5, 2624, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:59', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2630, N'搴撳瓨璋冨害鍗曞鎵?, N'erp:stock-move:update-status', 3, 6, 2624, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:13:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2631, N'搴撳瓨鐩樼偣', N'', 2, 6, 2583, N'check', N'ep:circle-check-filled', N'erp/stock/check/index', N'ErpStockCheck', 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'1', N'2024-02-08 08:31:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2632, N'搴撳瓨鐩樼偣鍗曟煡璇?, N'erp:stock-check:query', 3, 1, 2631, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2633, N'搴撳瓨鐩樼偣鍗曞垱寤?, N'erp:stock-check:create', 3, 2, 2631, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:52', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2634, N'搴撳瓨鐩樼偣鍗曟洿鏂?, N'erp:stock-check:update', 3, 3, 2631, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2635, N'搴撳瓨鐩樼偣鍗曞垹闄?, N'erp:stock-check:delete', 3, 4, 2631, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2636, N'搴撳瓨鐩樼偣鍗曞鍑?, N'erp:stock-check:export', 3, 5, 2631, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:59', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2637, N'搴撳瓨鐩樼偣鍗曞鎵?, N'erp:stock-check:update-status', 3, 6, 2631, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:13:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2638, N'閿€鍞鍗?, N'', 2, 1, 2617, N'order', N'fa:first-order', N'erp/sale/order/index', N'ErpSaleOrder', 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'1', N'2024-02-10 21:59:20', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2639, N'閿€鍞鍗曟煡璇?, N'erp:sale-order:query', 3, 1, 2638, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2640, N'閿€鍞鍗曞垱寤?, N'erp:sale-order:create', 3, 2, 2638, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:52', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2641, N'閿€鍞鍗曟洿鏂?, N'erp:sale-order:update', 3, 3, 2638, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2642, N'閿€鍞鍗曞垹闄?, N'erp:sale-order:delete', 3, 4, 2638, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2643, N'閿€鍞鍗曞鍑?, N'erp:sale-order:export', 3, 5, 2638, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:59', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2644, N'閿€鍞鍗曞鎵?, N'erp:sale-order:update-status', 3, 6, 2638, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:13:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2645, N'璐㈠姟绠＄悊', N'', 1, 50, 2563, N'finance', N'ep:money', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-10 08:05:58', N'1', N'2024-02-10 08:06:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2646, N'缁撶畻璐︽埛', N'', 2, 10, 2645, N'account', N'fa:universal-access', N'erp/finance/account/index', N'ErpAccount', 0, N'1', N'1', N'1', N'', N'2024-02-10 00:15:07', N'1', N'2024-02-14 08:24:31', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2647, N'缁撶畻璐︽埛鏌ヨ', N'erp:account:query', 3, 1, 2646, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-10 00:15:07', N'', N'2024-02-10 00:15:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2648, N'缁撶畻璐︽埛鍒涘缓', N'erp:account:create', 3, 2, 2646, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-10 00:15:07', N'', N'2024-02-10 00:15:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2649, N'缁撶畻璐︽埛鏇存柊', N'erp:account:update', 3, 3, 2646, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-10 00:15:07', N'', N'2024-02-10 00:15:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2650, N'缁撶畻璐︽埛鍒犻櫎', N'erp:account:delete', 3, 4, 2646, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-10 00:15:07', N'', N'2024-02-10 00:15:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2651, N'缁撶畻璐︽埛瀵煎嚭', N'erp:account:export', 3, 5, 2646, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-10 00:15:07', N'', N'2024-02-10 00:15:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2652, N'閿€鍞嚭搴?, N'', 2, 2, 2617, N'out', N'ep:sold-out', N'erp/sale/out/index', N'ErpSaleOut', 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'1', N'2024-02-10 22:02:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2653, N'閿€鍞嚭搴撴煡璇?, N'erp:sale-out:query', 3, 1, 2652, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2654, N'閿€鍞嚭搴撳垱寤?, N'erp:sale-out:create', 3, 2, 2652, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:52', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2655, N'閿€鍞嚭搴撴洿鏂?, N'erp:sale-out:update', 3, 3, 2652, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2656, N'閿€鍞嚭搴撳垹闄?, N'erp:sale-out:delete', 3, 4, 2652, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2657, N'閿€鍞嚭搴撳鍑?, N'erp:sale-out:export', 3, 5, 2652, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:59', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2658, N'閿€鍞嚭搴撳鎵?, N'erp:sale-out:update-status', 3, 6, 2652, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:13:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2659, N'閿€鍞€€璐?, N'', 2, 3, 2617, N'return', N'fa-solid:bone', N'erp/sale/return/index', N'ErpSaleReturn', 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'1', N'2024-02-12 06:12:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2660, N'閿€鍞€€璐ф煡璇?, N'erp:sale-return:query', 3, 1, 2659, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2661, N'閿€鍞€€璐у垱寤?, N'erp:sale-return:create', 3, 2, 2659, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:52', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2662, N'閿€鍞€€璐ф洿鏂?, N'erp:sale-return:update', 3, 3, 2659, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:55', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2663, N'閿€鍞€€璐у垹闄?, N'erp:sale-return:delete', 3, 4, 2659, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2664, N'閿€鍞€€璐у鍑?, N'erp:sale-return:export', 3, 5, 2659, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:12:59', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2665, N'閿€鍞€€璐у鎵?, N'erp:sale-return:update-status', 3, 6, 2659, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-07 11:13:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2666, N'閲囪喘璁㈠崟', N'', 2, 1, 2602, N'order', N'fa-solid:border-all', N'erp/purchase/order/index', N'ErpPurchaseOrder', 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'1', N'2024-02-12 08:51:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2667, N'閲囪喘璁㈠崟鏌ヨ', N'erp:purchase-order:query', 3, 1, 2666, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:17', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2668, N'閲囪喘璁㈠崟鍒涘缓', N'erp:purchase-order:create', 3, 2, 2666, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:44:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2669, N'閲囪喘璁㈠崟鏇存柊', N'erp:purchase-order:update', 3, 3, 2666, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:44:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2670, N'閲囪喘璁㈠崟鍒犻櫎', N'erp:purchase-order:delete', 3, 4, 2666, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:00', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2671, N'閲囪喘璁㈠崟瀵煎嚭', N'erp:purchase-order:export', 3, 5, 2666, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2672, N'閲囪喘璁㈠崟瀹℃壒', N'erp:purchase-order:update-status', 3, 6, 2666, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2673, N'閲囪喘鍏ュ簱', N'', 2, 2, 2602, N'in', N'fa-solid:gopuram', N'erp/purchase/in/index', N'ErpPurchaseIn', 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'1', N'2024-02-12 11:19:27', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2674, N'閲囪喘鍏ュ簱鏌ヨ', N'erp:purchase-in:query', 3, 1, 2673, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:17', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2675, N'閲囪喘鍏ュ簱鍒涘缓', N'erp:purchase-in:create', 3, 2, 2673, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:44:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2676, N'閲囪喘鍏ュ簱鏇存柊', N'erp:purchase-in:update', 3, 3, 2673, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:44:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2677, N'閲囪喘鍏ュ簱鍒犻櫎', N'erp:purchase-in:delete', 3, 4, 2673, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:00', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2678, N'閲囪喘鍏ュ簱瀵煎嚭', N'erp:purchase-in:export', 3, 5, 2673, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2679, N'閲囪喘鍏ュ簱瀹℃壒', N'erp:purchase-in:update-status', 3, 6, 2673, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2680, N'閲囪喘閫€璐?, N'', 2, 3, 2602, N'return', N'ep:minus', N'erp/purchase/return/index', N'ErpPurchaseReturn', 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'1', N'2024-02-12 20:51:02', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2681, N'閲囪喘閫€璐ф煡璇?, N'erp:purchase-return:query', 3, 1, 2680, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:17', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2682, N'閲囪喘閫€璐у垱寤?, N'erp:purchase-return:create', 3, 2, 2680, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:44:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2683, N'閲囪喘閫€璐ф洿鏂?, N'erp:purchase-return:update', 3, 3, 2680, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:44:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2684, N'閲囪喘閫€璐у垹闄?, N'erp:purchase-return:delete', 3, 4, 2680, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:00', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2685, N'閲囪喘閫€璐у鍑?, N'erp:purchase-return:export', 3, 5, 2680, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2686, N'閲囪喘閫€璐у鎵?, N'erp:purchase-return:update-status', 3, 6, 2680, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2687, N'浠樻鍗?, N'', 2, 1, 2645, N'payment', N'ep:caret-right', N'erp/finance/payment/index', N'ErpFinancePayment', 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'1', N'2024-02-14 08:24:23', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2688, N'浠樻鍗曟煡璇?, N'erp:finance-payment:query', 3, 1, 2687, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:17', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2689, N'浠樻鍗曞垱寤?, N'erp:finance-payment:create', 3, 2, 2687, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:44:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2690, N'浠樻鍗曟洿鏂?, N'erp:finance-payment:update', 3, 3, 2687, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:44:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2691, N'浠樻鍗曞垹闄?, N'erp:finance-payment:delete', 3, 4, 2687, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:00', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2692, N'浠樻鍗曞鍑?, N'erp:finance-payment:export', 3, 5, 2687, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2693, N'浠樻鍗曞鎵?, N'erp:finance-payment:update-status', 3, 6, 2687, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2694, N'鏀舵鍗?, N'', 2, 2, 2645, N'receipt', N'ep:expand', N'erp/finance/receipt/index', N'ErpFinanceReceipt', 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'1', N'2024-02-15 19:35:45', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2695, N'鏀舵鍗曟煡璇?, N'erp:finance-receipt:query', 3, 1, 2694, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:17', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2696, N'鏀舵鍗曞垱寤?, N'erp:finance-receipt:create', 3, 2, 2694, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:44:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2697, N'鏀舵鍗曟洿鏂?, N'erp:finance-receipt:update', 3, 3, 2694, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:44:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2698, N'鏀舵鍗曞垹闄?, N'erp:finance-receipt:delete', 3, 4, 2694, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:00', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2699, N'鏀舵鍗曞鍑?, N'erp:finance-receipt:export', 3, 5, 2694, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2700, N'鏀舵鍗曞鎵?, N'erp:finance-receipt:update-status', 3, 6, 2694, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-02-05 16:08:56', N'', N'2024-02-12 00:45:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2701, N'寰呭姙浜嬮」', N'', 2, 0, 2397, N'backlog', N'fa-solid:tasks', N'crm/backlog/index', N'CrmBacklog', 0, N'1', N'1', N'1', N'1', N'2024-02-17 17:17:11', N'1', N'2024-02-17 17:17:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2702, N'ERP 棣栭〉', N'erp:statistics:query', 2, 0, 2563, N'home', N'ep:home-filled', N'erp/home/index.vue', N'ErpHome', 0, N'1', N'1', N'1', N'1', N'2024-02-18 16:49:40', N'1', N'2024-02-26 21:12:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2703, N'鍟嗘満鐘舵€侀厤缃?, N'', 2, 4, 2524, N'business-status', N'fa-solid:charging-station', N'crm/business/status/index', N'CrmBusinessStatus', 0, N'1', N'1', N'1', N'1', N'2024-02-21 20:15:17', N'1', N'2024-02-21 20:15:17', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2704, N'鍟嗘満鐘舵€佹煡璇?, N'crm:business-status:query', 3, 1, 2703, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-21 20:35:36', N'1', N'2024-02-21 20:36:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2705, N'鍟嗘満鐘舵€佸垱寤?, N'crm:business-status:create', 3, 2, 2703, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-21 20:35:57', N'1', N'2024-02-21 20:35:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2706, N'鍟嗘満鐘舵€佹洿鏂?, N'crm:business-status:update', 3, 3, 2703, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-21 20:36:21', N'1', N'2024-02-21 20:36:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2707, N'鍟嗘満鐘舵€佸垹闄?, N'crm:business-status:delete', 3, 4, 2703, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-21 20:36:36', N'1', N'2024-02-21 20:36:36', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2708, N'鍚堝悓閰嶇疆', N'', 2, 5, 2524, N'contract-config', N'ep:connection', N'crm/contract/config/index', N'CrmContractConfig', 0, N'1', N'1', N'1', N'1', N'2024-02-24 16:44:40', N'1', N'2024-02-24 16:44:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2709, N'瀹㈡埛鍏捣閰嶇疆鏌ヨ', N'crm:customer-pool-config:query', 3, 2, 2516, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-24 16:45:19', N'1', N'2024-02-24 16:45:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2710, N'鍚堝悓閰嶇疆鏇存柊', N'crm:contract-config:update', 3, 1, 2708, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-24 16:45:56', N'1', N'2024-02-24 16:45:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2711, N'鍚堝悓閰嶇疆鏌ヨ', N'crm:contract-config:query', 3, 2, 2708, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-02-24 16:46:16', N'1', N'2024-02-24 16:46:16', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2712, N'瀹㈡埛鍒嗘瀽', N'crm:statistics-customer:query', 2, 0, 2560, N'customer', N'ep:avatar', N'crm/statistics/customer/index.vue', N'CrmStatisticsCustomer', 0, N'1', N'1', N'1', N'1', N'2024-03-09 16:43:56', N'1', N'2024-05-04 20:38:50', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2713, N'鎶勯€佹垜鐨?, N'bpm:process-instance-cc:query', 2, 30, 1200, N'copy', N'ep:copy-document', N'bpm/task/copy/index', N'BpmProcessInstanceCopy', 0, N'1', N'1', N'1', N'1', N'2024-03-17 21:50:23', N'1', N'2024-04-24 19:55:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2714, N'娴佺▼鍒嗙被', N'', 2, 3, 1186, N'category', N'fa:object-ungroup', N'bpm/category/index', N'BpmCategory', 0, N'1', N'1', N'1', N'', N'2024-03-08 02:00:51', N'1', N'2024-03-21 23:51:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2715, N'鍒嗙被鏌ヨ', N'bpm:category:query', 3, 1, 2714, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-03-08 02:00:51', N'1', N'2024-03-19 14:36:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2716, N'鍒嗙被鍒涘缓', N'bpm:category:create', 3, 2, 2714, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-03-08 02:00:51', N'1', N'2024-03-19 14:36:31', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2717, N'鍒嗙被鏇存柊', N'bpm:category:update', 3, 3, 2714, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-03-08 02:00:51', N'1', N'2024-03-19 14:36:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2718, N'鍒嗙被鍒犻櫎', N'bpm:category:delete', 3, 4, 2714, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-03-08 02:00:51', N'1', N'2024-03-19 14:36:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2720, N'鍙戣捣娴佺▼', N'', 2, 0, 1200, N'create', N'fa-solid:grin-stars', N'bpm/processInstance/create/index', N'BpmProcessInstanceCreate', 0, N'1', N'0', N'1', N'1', N'2024-03-19 19:46:05', N'1', N'2024-03-23 19:03:42', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2721, N'娴佺▼瀹炰緥', N'', 2, 10, 1186, N'process-instance/manager', N'fa:square', N'bpm/processInstance/manager/index', N'BpmProcessInstanceManager', 0, N'1', N'1', N'1', N'1', N'2024-03-21 23:57:30', N'1', N'2024-03-21 23:57:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2722, N'娴佺▼瀹炰緥鐨勬煡璇紙绠＄悊鍛橈級', N'bpm:process-instance:manager-query', 3, 1, 2721, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-03-22 08:18:27', N'1', N'2024-03-22 08:19:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2723, N'娴佺▼瀹炰緥鐨勫彇娑堬紙绠＄悊鍛橈級', N'bpm:process-instance:cancel-by-admin', 3, 2, 2721, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-03-22 08:19:25', N'1', N'2024-03-22 08:19:25', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2724, N'娴佺▼浠诲姟', N'', 2, 11, 1186, N'process-tasnk', N'ep:collection-tag', N'bpm/task/manager/index', N'BpmManagerTask', 0, N'1', N'1', N'1', N'1', N'2024-03-22 08:43:22', N'1', N'2024-03-22 08:43:27', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2725, N'娴佺▼浠诲姟鐨勬煡璇紙绠＄悊鍛橈級', N'bpm:task:mananger-query', 3, 1, 2724, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-03-22 08:43:49', N'1', N'2024-03-22 08:43:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2726, N'娴佺▼鐩戝惉鍣?, N'', 2, 5, 1186, N'process-listener', N'fa:assistive-listening-systems', N'bpm/processListener/index', N'BpmProcessListener', 0, N'1', N'1', N'1', N'', N'2024-03-09 16:05:34', N'1', N'2024-03-23 13:13:38', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2727, N'娴佺▼鐩戝惉鍣ㄦ煡璇?, N'bpm:process-listener:query', 3, 1, 2726, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-03-09 16:05:34', N'', N'2024-03-09 16:05:34', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2728, N'娴佺▼鐩戝惉鍣ㄥ垱寤?, N'bpm:process-listener:create', 3, 2, 2726, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-03-09 16:05:34', N'', N'2024-03-09 16:05:34', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2729, N'娴佺▼鐩戝惉鍣ㄦ洿鏂?, N'bpm:process-listener:update', 3, 3, 2726, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-03-09 16:05:34', N'', N'2024-03-09 16:05:34', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2730, N'娴佺▼鐩戝惉鍣ㄥ垹闄?, N'bpm:process-listener:delete', 3, 4, 2726, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-03-09 16:05:34', N'', N'2024-03-09 16:05:34', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2731, N'娴佺▼琛ㄨ揪寮?, N'', 2, 6, 1186, N'process-expression', N'fa:wpexplorer', N'bpm/processExpression/index', N'BpmProcessExpression', 0, N'1', N'1', N'1', N'', N'2024-03-09 22:35:08', N'1', N'2024-03-23 19:43:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2732, N'娴佺▼琛ㄨ揪寮忔煡璇?, N'bpm:process-expression:query', 3, 1, 2731, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-03-09 22:35:08', N'', N'2024-03-09 22:35:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2733, N'娴佺▼琛ㄨ揪寮忓垱寤?, N'bpm:process-expression:create', 3, 2, 2731, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-03-09 22:35:08', N'', N'2024-03-09 22:35:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2734, N'娴佺▼琛ㄨ揪寮忔洿鏂?, N'bpm:process-expression:update', 3, 3, 2731, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-03-09 22:35:08', N'', N'2024-03-09 22:35:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2735, N'娴佺▼琛ㄨ揪寮忓垹闄?, N'bpm:process-expression:delete', 3, 4, 2731, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-03-09 22:35:08', N'', N'2024-03-09 22:35:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2736, N'鍛樺伐涓氱哗', N'crm:statistics-performance:query', 2, 3, 2560, N'performance', N'ep:dish-dot', N'crm/statistics/performance/index', N'CrmStatisticsPerformance', 0, N'1', N'1', N'1', N'1', N'2024-04-05 13:49:20', N'1', N'2024-04-24 19:42:43', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2737, N'瀹㈡埛鐢诲儚', N'crm:statistics-portrait:query', 2, 4, 2560, N'portrait', N'ep:picture', N'crm/statistics/portrait/index', N'CrmStatisticsPortrait', 0, N'1', N'1', N'1', N'1', N'2024-04-05 13:57:40', N'1', N'2024-04-24 19:42:24', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2738, N'閿€鍞紡鏂?, N'crm:statistics-funnel:query', 2, 5, 2560, N'funnel', N'ep:grape', N'crm/statistics/funnel/index', N'CrmStatisticsFunnel', 0, N'1', N'1', N'1', N'1', N'2024-04-13 10:53:26', N'1', N'2024-04-24 19:39:33', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2739, N'娑堟伅涓績', N'', 1, 7, 1, N'messages', N'ep:chat-dot-round', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-22 23:54:30', N'1', N'2024-04-23 09:36:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2740, N'鐩戞帶涓績', N'', 1, 10, 2, N'monitors', N'ep:monitor', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-23 00:04:44', N'1', N'2024-04-23 00:04:44', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2741, N'棰嗗彇鍏捣瀹㈡埛', N'crm:customer:receive', 3, 1, 2546, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 19:47:45', N'1', N'2024-04-24 19:47:45', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2742, N'鍒嗛厤鍏捣瀹㈡埛', N'crm:customer:distribute', 3, 2, 2546, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 19:48:05', N'1', N'2024-04-24 19:48:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2743, N'鍟嗗搧缁熻鏌ヨ', N'statistics:product:query', 3, 1, 2545, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 19:50:05', N'1', N'2024-04-24 19:50:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2744, N'鍟嗗搧缁熻瀵煎嚭', N'statistics:product:export', 3, 2, 2545, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 19:50:26', N'1', N'2024-04-24 19:50:26', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2745, N'鏀粯娓犻亾鏌ヨ', N'pay:channel:query', 3, 10, 1126, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 19:53:01', N'1', N'2024-04-24 19:53:01', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2746, N'鏀粯娓犻亾鍒涘缓', N'pay:channel:create', 3, 11, 1126, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 19:53:18', N'1', N'2024-04-24 19:53:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2747, N'鏀粯娓犻亾鏇存柊', N'pay:channel:update', 3, 12, 1126, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 19:53:32', N'1', N'2024-04-24 19:53:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2748, N'鏀粯娓犻亾鍒犻櫎', N'pay:channel:delete', 3, 13, 1126, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 19:54:34', N'1', N'2024-04-24 19:54:34', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2749, N'鍟嗗搧鏀惰棌鏌ヨ', N'product:favorite:query', 3, 10, 2014, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 19:55:47', N'1', N'2024-04-24 19:55:47', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2750, N'鍟嗗搧娴忚鏌ヨ', N'product:browse-history:query', 3, 20, 2014, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 19:57:43', N'1', N'2024-04-24 19:57:43', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2751, N'鍞悗鍚屾剰', N'trade:after-sale:agree', 3, 2, 2073, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 19:58:40', N'1', N'2024-04-24 19:58:40', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2752, N'鍞悗涓嶅悓鎰?, N'trade:after-sale:disagree', 3, 3, 2073, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 19:59:03', N'1', N'2024-04-24 19:59:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2753, N'鍞悗纭閫€璐?, N'trade:after-sale:receive', 3, 4, 2073, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 20:00:07', N'1', N'2024-04-24 20:00:07', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2754, N'鍞悗纭閫€娆?, N'trade:after-sale:refund', 3, 5, 2073, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 20:00:24', N'1', N'2024-04-24 20:00:24', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2755, N'鍒犻櫎椤圭洰', N'report:go-view-project:delete', 3, 2, 2153, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 20:01:37', N'1', N'2024-04-24 20:01:37', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2756, N'浼氬憳绛夌骇璁板綍鏌ヨ', N'member:level-record:query', 3, 10, 2325, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 20:02:32', N'1', N'2024-04-24 20:02:32', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2757, N'浼氬憳缁忛獙璁板綍鏌ヨ', N'member:experience-record:query', 3, 11, 2325, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-04-24 20:02:51', N'1', N'2024-04-24 20:02:51', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2758, N'AI 澶фā鍨?, N'', 1, 400, 0, N'/ai', N'tabler:ai', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-05-07 15:07:56', N'1', N'2025-04-19 18:57:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2759, N'AI 瀵硅瘽', N'', 2, 1, 2758, N'chat', N'ep:message', N'ai/chat/index/index.vue', N'AiChat', 0, N'1', N'1', N'1', N'1', N'2024-05-07 15:09:14', N'1', N'2024-07-07 17:15:36', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2760, N'鎺у埗鍙?, N'', 1, 100, 2758, N'console', N'ep:setting', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-05-09 22:39:09', N'1', N'2024-05-24 23:34:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2761, N'API 瀵嗛挜', N'', 2, 0, 2760, N'api-key', N'ep:key', N'ai/model/apiKey/index.vue', N'AiApiKey', 0, N'1', N'1', N'1', N'', N'2024-05-09 14:52:56', N'1', N'2024-05-10 22:44:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2762, N'API 瀵嗛挜鏌ヨ', N'ai:api-key:query', 3, 1, 2761, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-05-09 14:52:56', N'1', N'2024-05-13 20:36:32', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2763, N'API 瀵嗛挜鍒涘缓', N'ai:api-key:create', 3, 2, 2761, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-05-09 14:52:56', N'1', N'2024-05-13 20:36:26', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2764, N'API 瀵嗛挜鏇存柊', N'ai:api-key:update', 3, 3, 2761, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-05-09 14:52:56', N'1', N'2024-05-13 20:36:42', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2765, N'API 瀵嗛挜鍒犻櫎', N'ai:api-key:delete', 3, 4, 2761, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-05-09 14:52:56', N'1', N'2024-05-13 20:36:48', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2767, N'妯″瀷閰嶇疆', N'', 2, 0, 2760, N'model', N'fa-solid:abacus', N'ai/model/model/index.vue', N'AiModel', 0, N'1', N'1', N'1', N'', N'2024-05-10 14:42:48', N'1', N'2025-03-03 09:57:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2768, N'鑱婂ぉ妯″瀷鏌ヨ', N'ai:model:query', 3, 1, 2767, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-05-10 14:42:48', N'1', N'2025-03-03 09:19:46', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2769, N'鑱婂ぉ妯″瀷鍒涘缓', N'ai:model:create', 3, 2, 2767, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-05-10 14:42:48', N'1', N'2025-03-03 09:20:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2770, N'鑱婂ぉ妯″瀷鏇存柊', N'ai:model:update', 3, 3, 2767, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-05-10 14:42:48', N'1', N'2025-03-03 09:20:14', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2771, N'鑱婂ぉ妯″瀷鍒犻櫎', N'ai:model:delete', 3, 4, 2767, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-05-10 14:42:48', N'1', N'2025-03-03 09:20:27', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2773, N'鑱婂ぉ瑙掕壊', N'', 2, 0, 2760, N'chat-role', N'fa:user-secret', N'ai/model/chatRole/index.vue', N'AiChatRole', 0, N'1', N'1', N'1', N'', N'2024-05-13 12:39:28', N'1', N'2024-05-13 20:41:45', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2774, N'鑱婂ぉ瑙掕壊鏌ヨ', N'ai:chat-role:query', 3, 1, 2773, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-05-13 12:39:28', N'', N'2024-05-13 12:39:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2775, N'鑱婂ぉ瑙掕壊鍒涘缓', N'ai:chat-role:create', 3, 2, 2773, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-05-13 12:39:28', N'', N'2024-05-13 12:39:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2776, N'鑱婂ぉ瑙掕壊鏇存柊', N'ai:chat-role:update', 3, 3, 2773, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-05-13 12:39:28', N'', N'2024-05-13 12:39:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2777, N'鑱婂ぉ瑙掕壊鍒犻櫎', N'ai:chat-role:delete', 3, 4, 2773, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-05-13 21:43:38', N'1', N'2024-05-13 21:43:38', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2778, N'鑱婂ぉ绠＄悊', N'', 2, 10, 2760, N'chat-conversation', N'ep:chat-square', N'ai/chat/manager/index.vue', N'AiChatManager', 0, N'1', N'1', N'1', N'', N'2024-05-24 15:39:18', N'1', N'2024-06-26 21:36:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2779, N'浼氳瘽鏌ヨ', N'ai:chat-conversation:query', 3, 1, 2778, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-05-24 15:39:18', N'1', N'2024-05-25 08:38:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2780, N'浼氳瘽鍒犻櫎', N'ai:chat-conversation:delete', 3, 2, 2778, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-05-24 15:39:18', N'1', N'2024-05-25 08:38:40', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2781, N'娑堟伅鏌ヨ', N'ai:chat-message:query', 3, 11, 2778, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-05-25 08:38:56', N'1', N'2024-05-25 08:38:56', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2782, N'娑堟伅鍒犻櫎', N'ai:chat-message:delete', 3, 12, 2778, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-05-25 08:39:10', N'1', N'2024-05-25 08:39:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2783, N'AI 缁樼敾', N'', 2, 2, 2758, N'image', N'ep:picture-rounded', N'ai/image/index/index.vue', N'AiImage', 0, N'1', N'1', N'1', N'1', N'2024-05-26 11:45:17', N'1', N'2024-07-07 17:18:59', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2784, N'缁樼敾绠＄悊', N'', 2, 11, 2760, N'image', N'fa:file-image-o', N'ai/image/manager/index.vue', N'AiImageManager', 0, N'1', N'1', N'1', N'', N'2024-06-26 13:32:31', N'1', N'2024-06-26 21:37:13', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2785, N'缁樼敾鏌ヨ', N'ai:image:query', 3, 1, 2784, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-06-26 13:32:31', N'1', N'2024-06-26 22:21:57', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2786, N'缁樼敾鍒犻櫎', N'ai:image:delete', 3, 4, 2784, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-06-26 13:32:31', N'1', N'2024-06-26 22:22:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2787, N'缁樺浘鏇存柊', N'ai:image:update', 3, 2, 2784, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-06-26 22:47:56', N'1', N'2024-08-31 09:21:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2788, N'闊充箰绠＄悊', N'', 2, 12, 2760, N'music', N'fa:music', N'ai/music/manager/index.vue', N'AiMusicManager', 0, N'1', N'1', N'1', N'', N'2024-06-27 15:03:33', N'1', N'2024-06-27 23:04:19', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2789, N'闊充箰鏌ヨ', N'ai:music:query', 3, 1, 2788, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-06-27 15:03:33', N'', N'2024-06-27 15:03:33', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2790, N'闊充箰鏇存柊', N'ai:music:update', 3, 3, 2788, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-06-27 15:03:33', N'', N'2024-06-27 15:03:33', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2791, N'闊充箰鍒犻櫎', N'ai:music:delete', 3, 4, 2788, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-06-27 15:03:33', N'', N'2024-06-27 15:03:33', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2792, N'AI 鍐欎綔', N'', 2, 3, 2758, N'write', N'fa-solid:book-reader', N'ai/write/index/index.vue', N'AiWrite', 0, N'1', N'1', N'1', N'1', N'2024-07-08 09:26:44', N'1', N'2024-07-16 13:03:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2793, N'鍐欎綔绠＄悊', N'', 2, 13, 2760, N'write', N'fa:bookmark-o', N'ai/write/manager/index.vue', N'AiWriteManager', 0, N'1', N'1', N'1', N'', N'2024-07-10 13:24:34', N'1', N'2024-07-10 21:31:59', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2794, N'AI 鍐欎綔鏌ヨ', N'ai:write:query', 3, 1, 2793, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-07-10 13:24:34', N'', N'2024-07-10 13:24:34', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2795, N'AI 鍐欎綔鍒犻櫎', N'ai:write:delete', 3, 4, 2793, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-07-10 13:24:34', N'', N'2024-07-10 13:24:34', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2796, N'AI 闊充箰', N'', 2, 4, 2758, N'music', N'fa:music', N'ai/music/index/index.vue', N'AiMusic', 0, N'1', N'1', N'1', N'1', N'2024-07-17 09:21:12', N'1', N'2024-07-29 21:11:52', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2797, N'瀹㈡湇涓績', N'', 2, 100, 2362, N'kefu', N'fa-solid:user-alt', N'mall/promotion/kefu/index', N'KeFu', 0, N'1', N'1', N'1', N'1', N'2024-07-17 23:49:05', N'1', N'2024-07-17 23:49:16', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2798, N'AI 鎬濈淮瀵煎浘', N'', 2, 6, 2758, N'mind-map', N'fa:sitemap', N'ai/mindmap/index/index.vue', N'AiMindMap', 0, N'1', N'1', N'1', N'1', N'2024-07-29 21:31:59', N'1', N'2025-03-02 18:57:31', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2799, N'瀵煎浘绠＄悊', N'', 2, 14, 2760, N'mind-map', N'fa:map', N'ai/mindmap/manager/index', N'AiMindMapManager', 0, N'1', N'1', N'1', N'', N'2024-08-10 09:15:09', N'1', N'2024-08-10 17:24:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2800, N'鎬濈淮瀵煎浘鏌ヨ', N'ai:mind-map:query', 3, 1, 2799, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-08-10 09:15:09', N'', N'2024-08-10 09:15:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2801, N'鎬濈淮瀵煎浘鍒犻櫎', N'ai:mind-map:delete', 3, 4, 2799, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-08-10 09:15:09', N'', N'2024-08-10 09:15:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2802, N'浼氳瘽鏌ヨ', N'promotion:kefu-conversation:query', 3, 1, 2797, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-08-31 09:17:52', N'1', N'2024-08-31 09:18:52', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2803, N'浼氳瘽鏇存柊', N'promotion:kefu-conversation:update', 3, 2, 2797, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-08-31 09:18:15', N'1', N'2024-08-31 09:19:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2804, N'娑堟伅鏌ヨ', N'promotion:kefu-message:query', 3, 10, 2797, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-08-31 09:18:42', N'1', N'2024-08-31 09:18:42', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2805, N'浼氳瘽鍒犻櫎', N'promotion:kefu-conversation:delete', 3, 3, 2797, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-08-31 09:19:51', N'1', N'2024-08-31 09:20:32', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2806, N'娑堟伅鍙戦€?, N'promotion:kefu-message:send', 3, 12, 2797, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-08-31 09:20:06', N'1', N'2024-08-31 09:20:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2807, N'娑堟伅鏇存柊', N'promotion:kefu-message:update', 3, 11, 2797, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-08-31 09:20:22', N'1', N'2024-08-31 09:20:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2808, N'绉垎鍟嗗煄', N'', 2, 5, 2030, N'point-activity', N'ep:bowl', N'mall/promotion/point/activity/index', N'PointActivity', 0, N'1', N'1', N'1', N'', N'2024-09-21 05:36:42', N'1', N'2024-09-23 09:14:43', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2809, N'绉垎鍟嗗煄娲诲姩鏌ヨ', N'promotion:point-activity:query', 3, 1, 2808, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-09-21 05:36:42', N'1', N'2024-09-22 14:49:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2810, N'绉垎鍟嗗煄娲诲姩鍒涘缓', N'promotion:point-activity:create', 3, 2, 2808, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-09-21 05:36:42', N'1', N'2024-09-22 14:49:08', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2811, N'绉垎鍟嗗煄娲诲姩鏇存柊', N'promotion:point-activity:update', 3, 3, 2808, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-09-21 05:36:42', N'1', N'2024-09-22 14:49:10', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2812, N'绉垎鍟嗗煄娲诲姩鍒犻櫎', N'promotion:point-activity:delete', 3, 4, 2808, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-09-21 05:36:42', N'1', N'2024-09-22 14:49:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2813, N'绉垎鍟嗗煄娲诲姩瀵煎嚭', N'promotion:point-activity:export', 3, 5, 2808, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-09-21 05:36:42', N'1', N'2024-09-22 14:49:27', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2912, N'鍒涘缓鎺ㄥ箍鍛?, N'trade:brokerage-user:create', 3, 7, 2346, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-12-01 14:32:39', N'1', N'2024-12-01 14:32:39', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2913, N'娴佺▼娓呯悊', N'bpm:model:clean', 3, 7, 1193, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-01-17 19:32:06', N'1', N'2025-01-17 19:32:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2914, N'绉垎鍟嗗煄娲诲姩鍏抽棴', N'promotion:point-activity:close', 3, 6, 2808, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-01-23 20:23:34', N'1', N'2025-01-23 20:23:34', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2915, N'AI 鐭ヨ瘑搴?, N'', 2, 5, 2758, N'knowledge', N'ep:notebook', N'ai/knowledge/knowledge/index', N'AiKnowledge', 0, N'1', N'1', N'1', N'', N'2025-02-28 07:04:21', N'1', N'2025-03-02 18:58:37', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2916, N'AI 鐭ヨ瘑搴撴煡璇?, N'ai:knowledge:query', 3, 1, 2915, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2025-02-28 07:04:21', N'', N'2025-02-28 07:04:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2917, N'AI 鐭ヨ瘑搴撳垱寤?, N'ai:knowledge:create', 3, 2, 2915, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2025-02-28 07:04:21', N'', N'2025-02-28 07:04:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2918, N'AI 鐭ヨ瘑搴撴洿鏂?, N'ai:knowledge:update', 3, 3, 2915, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2025-02-28 07:04:21', N'', N'2025-02-28 07:04:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2919, N'AI 鐭ヨ瘑搴撳垹闄?, N'ai:knowledge:delete', 3, 4, 2915, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2025-02-28 07:04:21', N'', N'2025-02-28 07:04:21', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2920, N'宸ュ叿绠＄悊', N'', 2, 0, 2760, N'tool', N'fa-solid:tools', N'ai/model/tool/index.vue', N'AiTool', 0, N'1', N'1', N'1', N'', N'2025-03-14 11:19:29', N'1', N'2025-03-14 19:20:18', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2921, N'宸ュ叿鏌ヨ', N'ai:tool:query', 3, 1, 2920, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2025-03-14 11:19:29', N'', N'2025-03-14 11:19:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2922, N'宸ュ叿鍒涘缓', N'ai:tool:create', 3, 2, 2920, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2025-03-14 11:19:29', N'', N'2025-03-14 11:19:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2923, N'宸ュ叿鏇存柊', N'ai:tool:update', 3, 3, 2920, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2025-03-14 11:19:29', N'', N'2025-03-14 11:19:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (2924, N'宸ュ叿鍒犻櫎', N'ai:tool:delete', 3, 4, 2920, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2025-03-14 11:19:29', N'', N'2025-03-14 11:19:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4000, N'IoT 鐗╄仈缃?, N'', 1, 500, 0, N'/iot', N'fa-solid:hdd', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-08-10 09:55:28', N'1', N'2024-12-07 15:58:34', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4001, N'璁惧鎺ュ叆', N'', 1, 2, 4000, N'device', N'ep:platform', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-08-10 09:57:56', N'1', N'2025-02-27 08:39:49', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4002, N'浜у搧绠＄悊', N'', 2, 2, 4001, N'product', N'fa-solid:tools', N'iot/product/product/index', N'IoTProduct', 0, N'1', N'1', N'1', N'', N'2024-08-10 02:38:02', N'1', N'2024-12-07 18:47:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4003, N'浜у搧鏌ヨ', N'iot:product:query', 3, 1, 4002, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-08-10 02:38:02', N'', N'2024-12-07 15:55:00', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4004, N'浜у搧鍒涘缓', N'iot:product:create', 3, 2, 4002, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-08-10 02:38:02', N'', N'2024-12-07 15:55:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4005, N'浜у搧鏇存柊', N'iot:product:update', 3, 3, 4002, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-08-10 02:38:02', N'', N'2024-12-07 15:55:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4006, N'浜у搧鍒犻櫎', N'iot:product:delete', 3, 4, 4002, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-08-10 02:38:02', N'', N'2024-12-07 15:55:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4007, N'浜у搧瀵煎嚭', N'iot:product:export', 3, 5, 4002, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-08-10 02:38:02', N'', N'2024-12-07 15:55:13', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4008, N'璁惧绠＄悊', N'', 2, 4, 4001, N'device', N'fa:mobile', N'iot/device/device/index', N'IoTDevice', 0, N'1', N'1', N'1', N'', N'2024-09-16 18:48:19', N'1', N'2024-12-14 11:39:30', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4009, N'璁惧鏌ヨ', N'iot:device:query', 3, 1, 4008, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-09-16 18:48:19', N'1', N'2024-12-07 15:55:40', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4010, N'璁惧鍒涘缓', N'iot:device:create', 3, 2, 4008, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-09-16 18:48:19', N'1', N'2024-12-07 15:55:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4011, N'璁惧鏇存柊', N'iot:device:update', 3, 3, 4008, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-09-16 18:48:19', N'1', N'2024-12-07 15:55:42', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4012, N'璁惧鍒犻櫎', N'iot:device:delete', 3, 4, 4008, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-09-16 18:48:19', N'1', N'2024-12-07 15:55:43', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4013, N'璁惧瀵煎嚭', N'iot:device:export', 3, 5, 4008, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'', N'2024-09-16 18:48:19', N'1', N'2024-12-07 15:55:44', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4014, N'浜у搧鍒嗙被', N'', 2, 1, 4001, N'product-category', N'ep:notebook', N'iot/product/category/index', N'IotProductCategory', 0, N'1', N'1', N'1', N'', N'2024-12-07 16:01:35', N'1', N'2024-12-07 16:31:52', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4015, N'浜у搧鍒嗙被鏌ヨ', N'iot:product-category:query', 3, 1, 4014, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-07 16:01:35', N'', N'2024-12-07 16:01:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4016, N'浜у搧鍒嗙被鍒涘缓', N'iot:product-category:create', 3, 2, 4014, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-07 16:01:35', N'', N'2024-12-07 16:01:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4017, N'浜у搧鍒嗙被鏇存柊', N'iot:product-category:update', 3, 3, 4014, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-07 16:01:35', N'', N'2024-12-07 16:01:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4018, N'浜у搧鍒嗙被鍒犻櫎', N'iot:product-category:delete', 3, 4, 4014, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-07 16:01:35', N'', N'2024-12-07 16:01:35', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4025, N'鎻掍欢绠＄悊', N'', 2, 5, 4047, N'plugin-config', N'ep:folder-opened', N'iot/plugin/index', N'IoTPlugin', 0, N'1', N'1', N'1', N'', N'2024-12-09 21:25:06', N'1', N'2025-02-05 22:23:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4026, N'鎻掍欢鏌ヨ', N'iot:plugin-config:query', 3, 1, 4025, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-09 21:25:06', N'', N'2025-02-05 21:23:20', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4027, N'鎻掍欢鍒涘缓', N'iot:plugin-config:create', 3, 2, 4025, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-09 21:25:06', N'', N'2025-02-05 21:23:16', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4028, N'鎻掍欢鏇存柊', N'iot:plugin-config:update', 3, 3, 4025, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-09 21:25:06', N'', N'2025-02-05 21:23:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4029, N'鎻掍欢鍒犻櫎', N'iot:plugin-config:delete', 3, 4, 4025, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-09 21:25:06', N'', N'2025-02-05 21:23:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4030, N'鎻掍欢瀵煎嚭', N'iot:plugin-config:export', 3, 5, 4025, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-09 21:25:06', N'', N'2025-02-05 21:23:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4031, N'璁惧鍒嗙粍', N'', 2, 3, 4001, N'device-group', N'fa-solid:layer-group', N'iot/device/group/index', N'IotDeviceGroup', 0, N'1', N'1', N'1', N'', N'2024-12-14 17:08:29', N'1', N'2024-12-14 17:09:17', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4032, N'璁惧鍒嗙粍鏌ヨ', N'iot:device-group:query', 3, 1, 4031, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-14 17:08:29', N'', N'2024-12-14 17:08:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4033, N'璁惧鍒嗙粍鍒涘缓', N'iot:device-group:create', 3, 2, 4031, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-14 17:08:29', N'', N'2024-12-14 17:08:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4034, N'璁惧鍒嗙粍鏇存柊', N'iot:device-group:update', 3, 3, 4031, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-14 17:08:29', N'', N'2024-12-14 17:08:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4035, N'璁惧鍒嗙粍鍒犻櫎', N'iot:device-group:delete', 3, 4, 4031, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-14 17:08:29', N'', N'2024-12-14 17:08:29', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4036, N'璁惧瀵煎叆', N'iot:device:import', 3, 6, 4008, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2024-12-15 10:35:47', N'1', N'2024-12-15 10:35:47', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4037, N'浜у搧鐗╂ā鍨?, N'', 2, 2, 4001, N'thing-model', N'ep:mostly-cloudy', N'iot/thingmodel/index', N'IoTThingModel', 0, N'0', N'0', N'0', N'', N'2024-12-16 17:17:50', N'1', N'2024-12-27 11:03:37', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4038, N'浜у搧鐗╂ā鍨嬪姛鑳芥煡璇?, N'iot:thing-model:query', 3, 1, 4037, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-16 17:17:51', N'', N'2025-03-17 09:14:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4039, N'浜у搧鐗╂ā鍨嬪姛鑳藉垱寤?, N'iot:thing-model:create', 3, 2, 4037, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-16 17:17:52', N'', N'2025-03-17 09:14:58', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4040, N'浜у搧鐗╂ā鍨嬪姛鑳芥洿鏂?, N'iot:thing-model:update', 3, 3, 4037, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-16 17:17:52', N'', N'2025-03-17 09:15:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4041, N'浜у搧鐗╂ā鍨嬪姛鑳藉垹闄?, N'iot:thing-model:delete', 3, 4, 4037, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-16 17:17:52', N'', N'2025-03-17 09:15:06', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4042, N'浜у搧鐗╂ā鍨嬪姛鑳藉鍑?, N'iot:thing-model:export', 3, 5, 4037, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2024-12-16 17:17:53', N'', N'2025-03-17 09:15:09', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4043, N'璁惧涓婅', N'iot:device:upstream', 3, 7, 4008, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-01-28 04:40:16', N'1', N'2025-01-31 22:45:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4044, N'璁惧灞炴€ф煡璇?, N'iot:device:property-query', 3, 10, 4008, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-01-28 11:52:54', N'1', N'2025-01-28 11:52:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4045, N'璁惧鏃ュ織鏌ヨ', N'iot:device:log-query', 3, 11, 4008, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-01-28 11:53:22', N'1', N'2025-01-28 11:53:22', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4046, N'璁惧涓嬭', N'iot:device:downstream', 3, 8, 4008, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-01-31 22:46:11', N'1', N'2025-01-31 22:46:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4047, N'杩愮淮绠＄悊', N'', 1, 2, 4000, N'operations', N'fa:cog', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-02-05 22:21:37', N'1', N'2025-02-05 22:22:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4048, N'瑙勫垯寮曟搸', N'', 1, 3, 4000, N'rule', N'fa-solid:cogs', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-02-11 14:10:54', N'1', N'2025-02-11 14:10:54', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4049, N'鍦烘櫙鑱斿姩', N'', 2, 1, 4048, N'scene', N'ep:link', N'iot/rule/scene/index', N'Scene', 0, N'1', N'1', N'1', N'1', N'2025-02-11 14:12:44', N'1', N'2025-02-12 10:15:36', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4050, N'IoT棣栭〉', N'', 2, 1, 4000, N'home', N'ep:home-filled', N'iot/home/index', N'IotHome', 0, N'1', N'1', N'1', N'1', N'2025-02-27 08:39:35', N'1', N'2025-02-27 08:40:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4051, N'鏁版嵁妗ユ', N'', 2, 0, 4048, N'data-bridge', N'ep:guide', N'iot/rule/databridge/index', N'IotDataBridge', 0, N'1', N'1', N'1', N'', N'2025-03-09 13:47:11', N'1', N'2025-03-09 13:47:51', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4052, N'IoT 鏁版嵁妗ユ鏌ヨ', N'iot:data-bridge:query', 3, 1, 4051, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2025-03-09 13:47:11', N'', N'2025-03-09 13:47:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4053, N'IoT 鏁版嵁妗ユ鍒涘缓', N'iot:data-bridge:create', 3, 2, 4051, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2025-03-09 13:47:11', N'', N'2025-03-09 13:47:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4054, N'IoT 鏁版嵁妗ユ鏇存柊', N'iot:data-bridge:update', 3, 3, 4051, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2025-03-09 13:47:11', N'', N'2025-03-09 13:47:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4055, N'IoT 鏁版嵁妗ユ鍒犻櫎', N'iot:data-bridge:delete', 3, 4, 4051, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2025-03-09 13:47:12', N'', N'2025-03-09 13:47:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (4056, N'IoT 鏁版嵁妗ユ瀵煎嚭', N'iot:data-bridge:export', 3, 5, 4051, N'', N'', N'', NULL, 0, N'1', N'1', N'1', N'', N'2025-03-09 13:47:12', N'', N'2025-03-09 13:47:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (5000, N'AI 宸ヤ綔娴?, N'', 2, 5, 2758, N'workflow', N'fa:hand-grab-o', N'ai/workflow/index.vue', N'AiWorkflow', 0, N'1', N'1', N'1', N'1', N'2025-03-25 09:50:27', N'1', N'2025-05-03 18:55:12', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (5001, N'AI 宸ヤ綔娴佹煡璇?, N'ai:workflow:query', 3, 1, 5000, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-03-25 09:51:11', N'1', N'2025-03-25 09:51:11', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (5002, N'AI 宸ヤ綔娴佸垱寤?, N'ai:workflow:create', 3, 2, 5000, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-03-25 09:51:28', N'1', N'2025-03-25 09:51:28', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (5003, N'AI 宸ヤ綔娴佹洿鏂?, N'ai:workflow:update', 3, 3, 5000, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-03-25 09:51:42', N'1', N'2025-03-25 09:51:42', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (5004, N'AI 宸ヤ綔娴佸垹闄?, N'ai:workflow:delete', 3, 4, 5000, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-03-25 09:51:55', N'1', N'2025-03-25 09:52:03', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (5005, N'AI 宸ヤ綔娴佹祴璇?, N'ai:workflow:test', 3, 5, 5000, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-03-30 10:29:41', N'1', N'2025-03-30 10:29:41', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (5009, N'浠〃鐩樿璁″櫒', N'', 2, 1, 1281, N'jimu-bi', N'fa:y-combinator', N'report/jmreport/bi', N'JimuBI', 0, N'1', N'1', N'1', N'1', N'2025-05-03 09:57:15', N'1', N'2025-05-03 10:02:05', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (5010, N'绉熸埛鍒囨崲', N'system:tenant:visit', 3, 999, 1138, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-05-05 15:25:32', N'1', N'2025-05-05 15:25:32', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (5011, N'杞处璁㈠崟鏌ヨ', N'pay:transfer:query', 3, 1, 2559, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-05-08 12:46:53', N'1', N'2025-05-08 12:46:53', N'0')
GO
INSERT INTO system_menu (id, name, permission, type, sort, parent_id, path, icon, component, component_name, status, visible, keep_alive, always_show, creator, create_time, updater, update_time, deleted) VALUES (5012, N'杞处璁㈠崟瀵煎嚭', N'pay:transfer:export', 3, 2, 2559, N'', N'', N'', N'', 0, N'1', N'1', N'1', N'1', N'2025-05-10 17:00:28', N'1', N'2025-05-10 17:00:28', N'0')
GO
SET IDENTITY_INSERT system_menu OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_notice
-- ----------------------------
DROP TABLE IF EXISTS system_notice
GO
CREATE TABLE system_notice
(
    id          bigint                                 NOT NULL PRIMARY KEY IDENTITY,
    title       nvarchar(50)                           NOT NULL,
    content     nvarchar(max)                          NOT NULL,
    type        tinyint                                NOT NULL,
    status      tinyint      DEFAULT 0                 NOT NULL,
    creator     nvarchar(64) DEFAULT ''                NULL,
    create_time datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64) DEFAULT ''                NULL,
    update_time datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit          DEFAULT 0                 NOT NULL,
    tenant_id   bigint       DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍏憡ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notice',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍏憡鏍囬',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notice',
     'COLUMN', N'title'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍏憡鍐呭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notice',
     'COLUMN', N'content'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍏憡绫诲瀷锛?閫氱煡 2鍏憡锛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_notice',
     'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍏憡鐘舵€侊紙0姝ｅ父 1鍏抽棴锛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_notice',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_notice',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notice',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_notice',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notice',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notice',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notice',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閫氱煡鍏憡琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_notice'
GO

-- ----------------------------
-- Records of system_notice
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_notice ON
GO
INSERT INTO system_notice (id, title, content, type, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, N'鑺嬮亾鐨勫叕浼?, N'<p>鏂扮増鏈唴瀹?33</p>', 1, 0, N'admin', N'2021-01-05 17:03:48', N'1', N'2022-05-04 21:00:20', N'0', 1)
GO
INSERT INTO system_notice (id, title, content, type, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, N'缁存姢閫氱煡锛?018-07-01 绯荤粺鍑屾櫒缁存姢', N'<p><img src="http://test.yudao.iocoder.cn/b7cb3cf49b4b3258bf7309a09dd2f4e5.jpg" alt="" data-href="">11112222<img src="http://test.yudao.iocoder.cn/fe44fc7bdb82ca421184b2eebbaee9e2148d4a1827479a4eb4521e11d2a062ba.png" alt="image" data-href="http://test.yudao.iocoder.cn/fe44fc7bdb82ca421184b2eebbaee9e2148d4a1827479a4eb4521e11d2a062ba.png">3333</p>', 2, 1, N'admin', N'2021-01-05 17:03:48', N'1', N'2025-04-18 23:56:40', N'0', 1)
GO
INSERT INTO system_notice (id, title, content, type, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4, N'鎴戞槸娴嬭瘯鏍囬', N'<p>鍝堝搱鍝堝搱123</p>', 1, 0, N'110', N'2022-02-22 01:01:25', N'110', N'2022-02-22 01:01:46', N'0', 121)
GO
SET IDENTITY_INSERT system_notice OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_notify_message
-- ----------------------------
DROP TABLE IF EXISTS system_notify_message
GO
CREATE TABLE system_notify_message
(
    id                bigint                                 NOT NULL PRIMARY KEY IDENTITY,
    user_id           bigint                                 NOT NULL,
    user_type         tinyint                                NOT NULL,
    template_id       bigint                                 NOT NULL,
    template_code     nvarchar(64)                           NOT NULL,
    template_nickname nvarchar(63)                           NOT NULL,
    template_content  nvarchar(1024)                         NOT NULL,
    template_type     int                                    NOT NULL,
    template_params   nvarchar(255)                          NOT NULL,
    read_status       varchar(1)                             NOT NULL,
    read_time         datetime2    DEFAULT NULL              NULL,
    creator           nvarchar(64) DEFAULT ''                NULL,
    create_time       datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater           nvarchar(64) DEFAULT ''                NULL,
    update_time       datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted           bit          DEFAULT 0                 NOT NULL,
    tenant_id         bigint       DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛id',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯＄増缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'template_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘缂栫爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'template_code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯＄増鍙戦€佷汉鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'template_nickname'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯＄増鍐呭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'template_content'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯＄増绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'template_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯＄増鍙傛暟',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'template_params'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁宸茶',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'read_status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'闃呰鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'read_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绔欏唴淇℃秷鎭〃',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_message'
GO

-- ----------------------------
-- Records of system_notify_message
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_notify_message ON
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, 1, 2, 1, N'test', N'123', N'鎴戞槸 1锛屾垜寮€濮?2 浜?, 1, N'{"name":"1","what":"2"}', N'1', N'2025-04-21 14:59:37', N'1', N'2023-01-28 11:44:08', N'1', N'2025-04-21 14:59:37', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3, 1, 2, 1, N'test', N'123', N'鎴戞槸 1锛屾垜寮€濮?2 浜?, 1, N'{"name":"1","what":"2"}', N'1', N'2025-04-21 14:59:37', N'1', N'2023-01-28 11:45:04', N'1', N'2025-04-21 14:59:37', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4, 103, 2, 2, N'register', N'绯荤粺娑堟伅', N'浣犲ソ锛屾杩?鍝堝搱 鍔犲叆澶у搴紒', 2, N'{"name":"鍝堝搱"}', N'0', NULL, N'1', N'2023-01-28 21:02:20', N'1', N'2023-01-28 21:02:20', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, 1, 2, 1, N'test', N'123', N'鎴戞槸 鑺嬭壙锛屾垜寮€濮?鍐欎唬鐮?浜?, 1, N'{"name":"鑺嬭壙","what":"鍐欎唬鐮?}', N'1', N'2025-04-21 14:59:37', N'1', N'2023-01-28 22:21:42', N'1', N'2025-04-21 14:59:37', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6, 1, 2, 1, N'test', N'123', N'鎴戞槸 鑺嬭壙锛屾垜寮€濮?鍐欎唬鐮?浜?, 1, N'{"name":"鑺嬭壙","what":"鍐欎唬鐮?}', N'1', N'2025-04-21 14:59:36', N'1', N'2023-01-28 22:22:07', N'1', N'2025-04-21 14:59:36', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (7, 1, 2, 1, N'test', N'123', N'鎴戞槸 2锛屾垜寮€濮?3 浜?, 1, N'{"name":"2","what":"3"}', N'1', N'2025-04-21 14:59:35', N'1', N'2023-01-28 23:45:21', N'1', N'2025-04-21 14:59:35', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (8, 1, 2, 2, N'register', N'绯荤粺娑堟伅', N'浣犲ソ锛屾杩?123 鍔犲叆澶у搴紒', 2, N'{"name":"123"}', N'1', N'2025-04-21 14:59:35', N'1', N'2023-01-28 23:50:21', N'1', N'2025-04-21 14:59:35', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (9, 247, 1, 4, N'brokerage_withdraw_audit_approve', N'system', N'鎮ㄥ湪2023-09-28 08:35:46鎻愮幇锟?.09鍏冪殑鐢宠宸查€氳繃瀹℃牳', 2, N'{"reason":null,"createTime":"2023-09-28 08:35:46","price":"0.09"}', N'0', NULL, N'1', N'2023-09-28 16:36:22', N'1', N'2023-09-28 16:36:22', N'0', 1)
GO
INSERT INTO system_notify_message (id, user_id, user_type, template_id, template_code, template_nickname, template_content, template_type, template_params, read_status, read_time, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (10, 247, 1, 4, N'brokerage_withdraw_audit_approve', N'system', N'鎮ㄥ湪2023-09-30 20:59:40鎻愮幇锟?.00鍏冪殑鐢宠宸查€氳繃瀹℃牳', 2, N'{"reason":null,"createTime":"2023-09-30 20:59:40","price":"1.00"}', N'0', NULL, N'1', N'2023-10-03 12:11:34', N'1', N'2023-10-03 12:11:34', N'0', 1)
GO
SET IDENTITY_INSERT system_notify_message OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_notify_template
-- ----------------------------
DROP TABLE IF EXISTS system_notify_template
GO
CREATE TABLE system_notify_template
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name        nvarchar(63)                            NOT NULL,
    code        nvarchar(64)                            NOT NULL,
    nickname    nvarchar(255)                           NOT NULL,
    content     nvarchar(1024)                          NOT NULL,
    type        tinyint                                 NOT NULL,
    params      nvarchar(255) DEFAULT NULL              NULL,
    status      tinyint                                 NOT NULL,
    remark      nvarchar(255) DEFAULT NULL              NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'涓婚敭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯＄増缂栫爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙戦€佷汉鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'nickname'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯＄増鍐呭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'content'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙傛暟鏁扮粍',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'params'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐘舵€?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶囨敞',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绔欏唴淇℃ā鏉胯〃',
     'SCHEMA', N'dbo',
     'TABLE', N'system_notify_template'
GO

-- ----------------------------
-- Table structure for system_oauth2_access_token
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_access_token
GO
CREATE TABLE system_oauth2_access_token
(
    id            bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    user_id       bigint                                  NOT NULL,
    user_type     tinyint                                 NOT NULL,
    user_info     nvarchar(512)                           NOT NULL,
    access_token  nvarchar(255)                           NOT NULL,
    refresh_token nvarchar(32)                            NOT NULL,
    client_id     nvarchar(255)                           NOT NULL,
    scopes        nvarchar(255) DEFAULT NULL              NULL,
    expires_time  datetime2                               NOT NULL,
    creator       nvarchar(64)  DEFAULT ''                NULL,
    create_time   datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater       nvarchar(64)  DEFAULT ''                NULL,
    update_time   datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted       bit           DEFAULT 0                 NOT NULL,
    tenant_id     bigint        DEFAULT 0                 NOT NULL
)
GO

CREATE INDEX idx_system_oauth2_access_token_01 ON system_oauth2_access_token (access_token)
GO
CREATE INDEX idx_system_oauth2_access_token_02 ON system_oauth2_access_token (refresh_token)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛淇℃伅',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'user_info'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璁块棶浠ょ墝',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'access_token'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒锋柊浠ょ墝',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'refresh_token'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀹㈡埛绔紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎺堟潈鑼冨洿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'scopes'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'杩囨湡鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'expires_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'OAuth2 璁块棶浠ょ墝',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_access_token'
GO

-- ----------------------------
-- Table structure for system_oauth2_approve
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_approve
GO
CREATE TABLE system_oauth2_approve
(
    id           bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    user_id      bigint                                  NOT NULL,
    user_type    tinyint                                 NOT NULL,
    client_id    nvarchar(255)                           NOT NULL,
    scope        nvarchar(255) DEFAULT ''                NOT NULL,
    approved     varchar(1)    DEFAULT '0'               NOT NULL,
    expires_time datetime2                               NOT NULL,
    creator      nvarchar(64)  DEFAULT ''                NULL,
    create_time  datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater      nvarchar(64)  DEFAULT ''                NULL,
    update_time  datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted      bit           DEFAULT 0                 NOT NULL,
    tenant_id    bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve',
     'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀹㈡埛绔紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve',
     'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎺堟潈鑼冨洿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve',
     'COLUMN', N'scope'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鎺ュ彈',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve',
     'COLUMN', N'approved'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'杩囨湡鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve',
     'COLUMN', N'expires_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'OAuth2 鎵瑰噯琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_approve'
GO

-- ----------------------------
-- Table structure for system_oauth2_client
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_client
GO
CREATE TABLE system_oauth2_client
(
    id                             bigint                                   NOT NULL PRIMARY KEY IDENTITY,
    client_id                      nvarchar(255)                            NOT NULL,
    secret                         nvarchar(255)                            NOT NULL,
    name                           nvarchar(255)                            NOT NULL,
    logo                           nvarchar(255)                            NOT NULL,
    description                    nvarchar(255)  DEFAULT NULL              NULL,
    status                         tinyint                                  NOT NULL,
    access_token_validity_seconds  int                                      NOT NULL,
    refresh_token_validity_seconds int                                      NOT NULL,
    redirect_uris                  nvarchar(255)                            NOT NULL,
    authorized_grant_types         nvarchar(255)                            NOT NULL,
    scopes                         nvarchar(255)  DEFAULT NULL              NULL,
    auto_approve_scopes            nvarchar(255)  DEFAULT NULL              NULL,
    authorities                    nvarchar(255)  DEFAULT NULL              NULL,
    resource_ids                   nvarchar(255)  DEFAULT NULL              NULL,
    additional_information         nvarchar(4000) DEFAULT NULL              NULL,
    creator                        nvarchar(64)   DEFAULT ''                NULL,
    create_time                    datetime2      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater                        nvarchar(64)   DEFAULT ''                NULL,
    update_time                    datetime2      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted                        bit            DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀹㈡埛绔紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀹㈡埛绔瘑閽?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'secret'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'搴旂敤鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'搴旂敤鍥炬爣',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'logo'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'搴旂敤鎻忚堪',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'description'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐘舵€?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璁块棶浠ょ墝鐨勬湁鏁堟湡',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'access_token_validity_seconds'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒锋柊浠ょ墝鐨勬湁鏁堟湡',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'refresh_token_validity_seconds'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙噸瀹氬悜鐨?URI 鍦板潃',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'redirect_uris'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎺堟潈绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'authorized_grant_types'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎺堟潈鑼冨洿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'scopes'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑷姩閫氳繃鐨勬巿鏉冭寖鍥?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'auto_approve_scopes'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏉冮檺',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'authorities'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璧勬簮',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'resource_ids'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'闄勫姞淇℃伅',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'additional_information'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'OAuth2 瀹㈡埛绔〃',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_client'
GO

-- ----------------------------
-- Records of system_oauth2_client
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_oauth2_client ON
GO
INSERT INTO system_oauth2_client (id, client_id, secret, name, logo, description, status, access_token_validity_seconds, refresh_token_validity_seconds, redirect_uris, authorized_grant_types, scopes, auto_approve_scopes, authorities, resource_ids, additional_information, creator, create_time, updater, update_time, deleted) VALUES (1, N'default', N'admin123', N'鑺嬮亾婧愮爜', N'http://test.yudao.iocoder.cn/20250502/sort2_1746189740718.png', N'鎴戞槸鎻忚堪', 0, 1800, 2592000, N'["https://www.iocoder.cn","https://doc.iocoder.cn"]', N'["password","authorization_code","implicit","refresh_token"]', N'["user.read","user.write"]', N'[]', N'["user.read","user.write"]', N'[]', N'{}', N'1', N'2022-05-11 21:47:12', N'1', N'2025-05-02 20:42:22', N'0')
GO
INSERT INTO system_oauth2_client (id, client_id, secret, name, logo, description, status, access_token_validity_seconds, refresh_token_validity_seconds, redirect_uris, authorized_grant_types, scopes, auto_approve_scopes, authorities, resource_ids, additional_information, creator, create_time, updater, update_time, deleted) VALUES (40, N'test', N'test2', N'biubiu', N'http://test.yudao.iocoder.cn/xx/20250502/ed07110a37464b5299f8bd7c67ad65c7_1746187077009.jpg', N'鍟﹀暒鍟﹀暒', 0, 1800, 43200, N'["https://www.iocoder.cn"]', N'["password","authorization_code","implicit"]', N'["user_info","projects"]', N'["user_info"]', N'[]', N'[]', N'{}', N'1', N'2022-05-12 00:28:20', N'1', N'2025-05-02 19:58:08', N'0')
GO
INSERT INTO system_oauth2_client (id, client_id, secret, name, logo, description, status, access_token_validity_seconds, refresh_token_validity_seconds, redirect_uris, authorized_grant_types, scopes, auto_approve_scopes, authorities, resource_ids, additional_information, creator, create_time, updater, update_time, deleted) VALUES (41, N'yudao-sso-demo-by-code', N'test', N'鍩轰簬鎺堟潈鐮佹ā寮忥紝濡備綍瀹炵幇 SSO 鍗曠偣鐧诲綍锛?, N'http://test.yudao.iocoder.cn/it/20250502/sign_1746181948685.png', NULL, 0, 1800, 43200, N'["http://127.0.0.1:18080"]', N'["authorization_code","refresh_token"]', N'["user.read","user.write"]', N'[]', N'[]', N'[]', NULL, N'1', N'2022-09-29 13:28:31', N'1', N'2025-05-02 18:32:30', N'0')
GO
INSERT INTO system_oauth2_client (id, client_id, secret, name, logo, description, status, access_token_validity_seconds, refresh_token_validity_seconds, redirect_uris, authorized_grant_types, scopes, auto_approve_scopes, authorities, resource_ids, additional_information, creator, create_time, updater, update_time, deleted) VALUES (42, N'yudao-sso-demo-by-password', N'test', N'鍩轰簬瀵嗙爜妯″紡锛屽浣曞疄鐜?SSO 鍗曠偣鐧诲綍锛?, N'http://test.yudao.iocoder.cn/604bdc695e13b3b22745be704d1f2aa8ee05c5f26f9fead6d1ca49005afbc857.jpeg', NULL, 0, 1800, 43200, N'["http://127.0.0.1:18080"]', N'["password","refresh_token"]', N'["user.read","user.write"]', N'[]', N'[]', N'[]', NULL, N'1', N'2022-10-04 17:40:16', N'1', N'2025-05-04 16:00:46', N'0')
GO
SET IDENTITY_INSERT system_oauth2_client OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_oauth2_code
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_code
GO
CREATE TABLE system_oauth2_code
(
    id           bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    user_id      bigint                                  NOT NULL,
    user_type    tinyint                                 NOT NULL,
    code         nvarchar(32)                            NOT NULL,
    client_id    nvarchar(255)                           NOT NULL,
    scopes       nvarchar(255) DEFAULT ''                NULL,
    expires_time datetime2                               NOT NULL,
    redirect_uri nvarchar(255) DEFAULT NULL              NULL,
    state        nvarchar(255) DEFAULT ''                NOT NULL,
    creator      nvarchar(64)  DEFAULT ''                NULL,
    create_time  datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater      nvarchar(64)  DEFAULT ''                NULL,
    update_time  datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted      bit           DEFAULT 0                 NOT NULL,
    tenant_id    bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎺堟潈鐮?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀹㈡埛绔紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎺堟潈鑼冨洿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'scopes'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'杩囨湡鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'expires_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙噸瀹氬悜鐨?URI 鍦板潃',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'redirect_uri'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐘舵€?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'state'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'OAuth2 鎺堟潈鐮佽〃',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_code'
GO

-- ----------------------------
-- Table structure for system_oauth2_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS system_oauth2_refresh_token
GO
CREATE TABLE system_oauth2_refresh_token
(
    id            bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    user_id       bigint                                  NOT NULL,
    refresh_token nvarchar(32)                            NOT NULL,
    user_type     tinyint                                 NOT NULL,
    client_id     nvarchar(255)                           NOT NULL,
    scopes        nvarchar(255) DEFAULT NULL              NULL,
    expires_time  datetime2                               NOT NULL,
    creator       nvarchar(64)  DEFAULT ''                NULL,
    create_time   datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater       nvarchar(64)  DEFAULT ''                NULL,
    update_time   datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted       bit           DEFAULT 0                 NOT NULL,
    tenant_id     bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒锋柊浠ょ墝',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token',
     'COLUMN', N'refresh_token'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token',
     'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀹㈡埛绔紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token',
     'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎺堟潈鑼冨洿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token',
     'COLUMN', N'scopes'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'杩囨湡鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token',
     'COLUMN', N'expires_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'OAuth2 鍒锋柊浠ょ墝',
     'SCHEMA', N'dbo',
     'TABLE', N'system_oauth2_refresh_token'
GO

-- ----------------------------
-- Table structure for system_operate_log
-- ----------------------------
DROP TABLE IF EXISTS system_operate_log
GO
CREATE TABLE system_operate_log
(
    id             bigint                                   NOT NULL PRIMARY KEY IDENTITY,
    trace_id       nvarchar(64)   DEFAULT ''                NOT NULL,
    user_id        bigint                                   NOT NULL,
    user_type      tinyint        DEFAULT 0                 NOT NULL,
    type           nvarchar(50)                             NOT NULL,
    sub_type       nvarchar(50)                             NOT NULL,
    biz_id         bigint                                   NOT NULL,
    action         nvarchar(2000) DEFAULT ''                NOT NULL,
    success        varchar(1)     DEFAULT '1'               NOT NULL,
    extra          nvarchar(2000) DEFAULT ''                NOT NULL,
    request_method nvarchar(16)   DEFAULT ''                NULL,
    request_url    nvarchar(255)  DEFAULT ''                NULL,
    user_ip        nvarchar(50)   DEFAULT NULL              NULL,
    user_agent     nvarchar(512)  DEFAULT NULL              NULL,
    creator        nvarchar(64)   DEFAULT ''                NULL,
    create_time    datetime2      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater        nvarchar(64)   DEFAULT ''                NULL,
    update_time    datetime2      DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted        bit            DEFAULT 0                 NOT NULL,
    tenant_id      bigint         DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏃ュ織涓婚敭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閾捐矾杩借釜缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'trace_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎿嶄綔妯″潡绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎿嶄綔鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'sub_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎿嶄綔鏁版嵁妯″潡缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'biz_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎿嶄綔鍐呭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'action'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎿嶄綔缁撴灉',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'success'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎷撳睍瀛楁',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'extra'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璇锋眰鏂规硶鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'request_method'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璇锋眰鍦板潃',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'request_url'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛 IP',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'user_ip'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'娴忚鍣?UA',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'user_agent'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎿嶄綔鏃ュ織璁板綍 V2 鐗堟湰',
     'SCHEMA', N'dbo',
     'TABLE', N'system_operate_log'
GO

-- ----------------------------
-- Table structure for system_post
-- ----------------------------
DROP TABLE IF EXISTS system_post
GO
CREATE TABLE system_post
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    code        nvarchar(64)                            NOT NULL,
    name        nvarchar(50)                            NOT NULL,
    sort        int                                     NOT NULL,
    status      tinyint                                 NOT NULL,
    remark      nvarchar(500) DEFAULT NULL              NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL,
    tenant_id   bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'宀椾綅ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_post',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'宀椾綅缂栫爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_post',
     'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'宀椾綅鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_post',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄剧ず椤哄簭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_post',
     'COLUMN', N'sort'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_post',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶囨敞',
     'SCHEMA', N'dbo',
     'TABLE', N'system_post',
     'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_post',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_post',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_post',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_post',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_post',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_post',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'宀椾綅淇℃伅琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_post'
GO

-- ----------------------------
-- Records of system_post
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_post ON
GO
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, N'ceo', N'钁ｄ簨闀?, 1, 0, N'', N'admin', N'2021-01-06 17:03:48', N'1', N'2023-02-11 15:19:04', N'0', 1)
GO
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, N'se', N'椤圭洰缁忕悊', 2, 0, N'', N'admin', N'2021-01-05 17:03:48', N'1', N'2023-11-15 09:18:20', N'0', 1)
GO
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4, N'user', N'鏅€氬憳宸?, 4, 0, N'111222', N'admin', N'2021-01-05 17:03:48', N'1', N'2025-03-24 21:32:40', N'0', 1)
GO
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, N'HR', N'浜哄姏璧勬簮', 5, 0, N'`', N'1', N'2024-03-24 20:45:40', N'1', N'2025-03-29 19:08:10', N'0', 1)
GO
SET IDENTITY_INSERT system_post OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_role
-- ----------------------------
DROP TABLE IF EXISTS system_role
GO
CREATE TABLE system_role
(
    id                  bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name                nvarchar(30)                            NOT NULL,
    code                nvarchar(100)                           NOT NULL,
    sort                int                                     NOT NULL,
    data_scope          tinyint       DEFAULT 1                 NOT NULL,
    data_scope_dept_ids nvarchar(500) DEFAULT ''                NOT NULL,
    status              tinyint                                 NOT NULL,
    type                tinyint                                 NOT NULL,
    remark              nvarchar(500) DEFAULT NULL              NULL,
    creator             nvarchar(64)  DEFAULT ''                NULL,
    create_time         datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater             nvarchar(64)  DEFAULT ''                NULL,
    update_time         datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted             bit           DEFAULT 0                 NOT NULL,
    tenant_id           bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瑙掕壊ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瑙掕壊鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瑙掕壊鏉冮檺瀛楃涓?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄剧ず椤哄簭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'sort'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏁版嵁鑼冨洿锛?锛氬叏閮ㄦ暟鎹潈闄?2锛氳嚜瀹氭暟鎹潈闄?3锛氭湰閮ㄩ棬鏁版嵁鏉冮檺 4锛氭湰閮ㄩ棬鍙婁互涓嬫暟鎹潈闄愶級',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'data_scope'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏁版嵁鑼冨洿 ( 鎸囧畾閮ㄩ棬鏁扮粍)',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'data_scope_dept_ids'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瑙掕壊鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瑙掕壊绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶囨敞',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瑙掕壊淇℃伅琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_role'
GO

-- ----------------------------
-- Records of system_role
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_role ON
GO
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, N'瓒呯骇绠＄悊鍛?, N'super_admin', 1, 1, N'', 0, 1, N'瓒呯骇绠＄悊鍛?, N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-22 05:08:21', N'0', 1)
GO
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, N'鏅€氳鑹?, N'common', 2, 2, N'', 0, 1, N'鏅€氳鑹?, N'admin', N'2021-01-05 17:03:48', N'', N'2022-02-22 05:08:20', N'0', 1)
GO
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3, N'CRM 绠＄悊鍛?, N'crm_admin', 2, 1, N'', 0, 1, N'CRM 涓撳睘瑙掕壊', N'1', N'2024-02-24 10:51:13', N'1', N'2024-02-24 02:51:32', N'0', 1)
GO
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (101, N'娴嬭瘯璐﹀彿', N'test', 0, 1, N'[]', 0, 2, N'123', N'', N'2021-01-06 13:49:35', N'1', N'2025-04-30 17:38:28', N'0', 1)
GO
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (109, N'绉熸埛绠＄悊鍛?, N'tenant_admin', 0, 1, N'', 0, 1, N'绯荤粺鑷姩鐢熸垚', N'1', N'2022-02-22 00:56:14', N'1', N'2022-02-22 00:56:14', N'0', 121)
GO
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (111, N'绉熸埛绠＄悊鍛?, N'tenant_admin', 0, 1, N'', 0, 1, N'绯荤粺鑷姩鐢熸垚', N'1', N'2022-03-07 21:37:58', N'1', N'2022-03-07 21:37:58', N'0', 122)
GO
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (155, N'娴嬭瘯鏁版嵁鏉冮檺', N'test-dp', 3, 2, N'[100,102,103,104,105,108]', 0, 2, N'', N'1', N'2025-03-31 14:58:06', N'1', N'2025-04-17 23:07:44', N'0', 1)
GO
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (158, N'2', N'3', 4, 1, N'', 0, 2, NULL, N'1', N'2025-04-17 20:08:08', N'1', N'2025-04-17 23:05:31', N'0', 1)
GO
SET IDENTITY_INSERT system_role OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_role_menu
-- ----------------------------
DROP TABLE IF EXISTS system_role_menu
GO
CREATE TABLE system_role_menu
(
    id          bigint                                 NOT NULL PRIMARY KEY IDENTITY,
    role_id     bigint                                 NOT NULL,
    menu_id     bigint                                 NOT NULL,
    creator     nvarchar(64) DEFAULT ''                NULL,
    create_time datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64) DEFAULT ''                NULL,
    update_time datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit          DEFAULT 0                 NOT NULL,
    tenant_id   bigint       DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑷缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role_menu',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瑙掕壊ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role_menu',
     'COLUMN', N'role_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑿滃崟ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role_menu',
     'COLUMN', N'menu_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_role_menu',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role_menu',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_role_menu',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role_menu',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role_menu',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role_menu',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瑙掕壊鍜岃彍鍗曞叧鑱旇〃',
     'SCHEMA', N'dbo',
     'TABLE', N'system_role_menu'
GO

-- ----------------------------
-- Records of system_role_menu
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_role_menu ON
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (263, 109, 1, N'1', N'2022-02-22 00:56:14', N'1', N'2022-02-22 00:56:14', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (434, 2, 1, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (454, 2, 1093, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (455, 2, 1094, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (460, 2, 1100, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (467, 2, 1107, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (476, 2, 1117, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (477, 2, 100, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (478, 2, 101, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (479, 2, 102, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (480, 2, 1126, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (481, 2, 103, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (483, 2, 104, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (485, 2, 105, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (488, 2, 107, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (490, 2, 108, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (492, 2, 109, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (498, 2, 1138, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (523, 2, 1224, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (524, 2, 1225, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (541, 2, 500, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (543, 2, 501, N'1', N'2022-02-22 13:09:12', N'1', N'2022-02-22 13:09:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (675, 2, 2, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (689, 2, 1077, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (690, 2, 1078, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (692, 2, 1083, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (693, 2, 1084, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (699, 2, 1090, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (703, 2, 106, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (704, 2, 110, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (705, 2, 111, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (706, 2, 112, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (707, 2, 113, N'1', N'2022-02-22 13:16:57', N'1', N'2022-02-22 13:16:57', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1296, 110, 1, N'110', N'2022-02-23 00:23:55', N'110', N'2022-02-23 00:23:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1578, 111, 1, N'1', N'2022-03-07 21:37:58', N'1', N'2022-03-07 21:37:58', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1604, 101, 1216, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1605, 101, 1217, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1606, 101, 1218, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1607, 101, 1219, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1608, 101, 1220, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1609, 101, 1221, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1610, 101, 5, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1611, 101, 1222, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1612, 101, 1118, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1613, 101, 1119, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1614, 101, 1120, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1615, 101, 1185, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1616, 101, 1186, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1617, 101, 1187, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1618, 101, 1188, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1619, 101, 1189, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1620, 101, 1190, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1621, 101, 1191, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1622, 101, 1192, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1623, 101, 1193, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1624, 101, 1194, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1625, 101, 1195, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1627, 101, 1197, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1628, 101, 1198, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1629, 101, 1199, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1630, 101, 1200, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1631, 101, 1201, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1632, 101, 1202, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1633, 101, 1207, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1634, 101, 1208, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1635, 101, 1209, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1636, 101, 1210, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1637, 101, 1211, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1638, 101, 1212, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1639, 101, 1213, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1640, 101, 1215, N'1', N'2022-03-19 21:45:52', N'1', N'2022-03-19 21:45:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1641, 101, 2, N'1', N'2022-04-01 22:21:24', N'1', N'2022-04-01 22:21:24', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1642, 101, 1031, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1643, 101, 1032, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1644, 101, 1033, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1645, 101, 1034, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1646, 101, 1035, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1647, 101, 1050, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1648, 101, 1051, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1649, 101, 1052, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1650, 101, 1053, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1651, 101, 1054, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1652, 101, 1056, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1653, 101, 1057, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1654, 101, 1058, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1655, 101, 1059, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1656, 101, 1060, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1657, 101, 1066, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1658, 101, 1067, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1659, 101, 1070, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1664, 101, 1075, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1666, 101, 1077, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1667, 101, 1078, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1668, 101, 1082, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1669, 101, 1083, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1670, 101, 1084, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1671, 101, 1085, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1672, 101, 1086, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1673, 101, 1087, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1674, 101, 1088, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1675, 101, 1089, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1679, 101, 1237, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1680, 101, 1238, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1681, 101, 1239, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1682, 101, 1240, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1683, 101, 1241, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1684, 101, 1242, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1685, 101, 1243, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1687, 101, 106, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1688, 101, 110, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1689, 101, 111, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1690, 101, 112, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1691, 101, 113, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1692, 101, 114, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1693, 101, 115, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1694, 101, 116, N'1', N'2022-04-01 22:21:37', N'1', N'2022-04-01 22:21:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1729, 109, 100, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1730, 109, 101, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1731, 109, 1063, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1732, 109, 1064, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1733, 109, 1001, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1734, 109, 1065, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1735, 109, 1002, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1736, 109, 1003, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1737, 109, 1004, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1738, 109, 1005, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1739, 109, 1006, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1740, 109, 1007, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1741, 109, 1008, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1742, 109, 1009, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1743, 109, 1010, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1744, 109, 1011, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1745, 109, 1012, N'1', N'2022-09-21 22:08:51', N'1', N'2022-09-21 22:08:51', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1746, 111, 100, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1747, 111, 101, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1748, 111, 1063, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1749, 111, 1064, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1750, 111, 1001, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1751, 111, 1065, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1752, 111, 1002, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1753, 111, 1003, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1754, 111, 1004, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1755, 111, 1005, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1756, 111, 1006, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1757, 111, 1007, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1758, 111, 1008, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1759, 111, 1009, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1760, 111, 1010, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1761, 111, 1011, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1762, 111, 1012, N'1', N'2022-09-21 22:08:52', N'1', N'2022-09-21 22:08:52', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1763, 109, 100, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1764, 109, 101, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1765, 109, 1063, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1766, 109, 1064, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1767, 109, 1001, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1768, 109, 1065, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1769, 109, 1002, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1770, 109, 1003, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1771, 109, 1004, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1772, 109, 1005, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1773, 109, 1006, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1774, 109, 1007, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1775, 109, 1008, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1776, 109, 1009, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1777, 109, 1010, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1778, 109, 1011, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1779, 109, 1012, N'1', N'2022-09-21 22:08:53', N'1', N'2022-09-21 22:08:53', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1780, 111, 100, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1781, 111, 101, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1782, 111, 1063, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1783, 111, 1064, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1784, 111, 1001, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1785, 111, 1065, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1786, 111, 1002, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1787, 111, 1003, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1788, 111, 1004, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1789, 111, 1005, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1790, 111, 1006, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1791, 111, 1007, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1792, 111, 1008, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1793, 111, 1009, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1794, 111, 1010, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1795, 111, 1011, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1796, 111, 1012, N'1', N'2022-09-21 22:08:54', N'1', N'2022-09-21 22:08:54', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1797, 109, 100, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1798, 109, 101, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1799, 109, 1063, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1800, 109, 1064, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1801, 109, 1001, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1802, 109, 1065, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1803, 109, 1002, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1804, 109, 1003, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1805, 109, 1004, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1806, 109, 1005, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1807, 109, 1006, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1808, 109, 1007, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1809, 109, 1008, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1810, 109, 1009, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1811, 109, 1010, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1812, 109, 1011, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1813, 109, 1012, N'1', N'2022-09-21 22:08:55', N'1', N'2022-09-21 22:08:55', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1814, 111, 100, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1815, 111, 101, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1816, 111, 1063, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1817, 111, 1064, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1818, 111, 1001, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1819, 111, 1065, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1820, 111, 1002, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1821, 111, 1003, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1822, 111, 1004, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1823, 111, 1005, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1824, 111, 1006, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1825, 111, 1007, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1826, 111, 1008, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1827, 111, 1009, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1828, 111, 1010, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1829, 111, 1011, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1830, 111, 1012, N'1', N'2022-09-21 22:08:56', N'1', N'2022-09-21 22:08:56', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1831, 109, 103, N'1', N'2022-09-21 22:43:23', N'1', N'2022-09-21 22:43:23', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1832, 109, 1017, N'1', N'2022-09-21 22:43:23', N'1', N'2022-09-21 22:43:23', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1833, 109, 1018, N'1', N'2022-09-21 22:43:23', N'1', N'2022-09-21 22:43:23', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1834, 109, 1019, N'1', N'2022-09-21 22:43:23', N'1', N'2022-09-21 22:43:23', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1835, 109, 1020, N'1', N'2022-09-21 22:43:23', N'1', N'2022-09-21 22:43:23', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1836, 111, 103, N'1', N'2022-09-21 22:43:24', N'1', N'2022-09-21 22:43:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1837, 111, 1017, N'1', N'2022-09-21 22:43:24', N'1', N'2022-09-21 22:43:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1838, 111, 1018, N'1', N'2022-09-21 22:43:24', N'1', N'2022-09-21 22:43:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1839, 111, 1019, N'1', N'2022-09-21 22:43:24', N'1', N'2022-09-21 22:43:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1840, 111, 1020, N'1', N'2022-09-21 22:43:24', N'1', N'2022-09-21 22:43:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1841, 109, 1036, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1842, 109, 1037, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1843, 109, 1038, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1844, 109, 1039, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1845, 109, 107, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1846, 111, 1036, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1847, 111, 1037, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1848, 111, 1038, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1849, 111, 1039, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1850, 111, 107, N'1', N'2022-09-21 22:48:13', N'1', N'2022-09-21 22:48:13', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1991, 2, 1024, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1992, 2, 1025, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1993, 2, 1026, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1994, 2, 1027, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1995, 2, 1028, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1996, 2, 1029, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1997, 2, 1030, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1998, 2, 1031, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1999, 2, 1032, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2000, 2, 1033, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2001, 2, 1034, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2002, 2, 1035, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2003, 2, 1036, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2004, 2, 1037, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2005, 2, 1038, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2006, 2, 1039, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2007, 2, 1040, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2008, 2, 1042, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2009, 2, 1043, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2010, 2, 1045, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2011, 2, 1046, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2012, 2, 1048, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2013, 2, 1050, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2014, 2, 1051, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2015, 2, 1052, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2016, 2, 1053, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2017, 2, 1054, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2018, 2, 1056, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2019, 2, 1057, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2020, 2, 1058, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2021, 2, 2083, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2022, 2, 1059, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2023, 2, 1060, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2024, 2, 1063, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2025, 2, 1064, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2026, 2, 1065, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2027, 2, 1066, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2028, 2, 1067, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2029, 2, 1070, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2034, 2, 1075, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2036, 2, 1082, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2037, 2, 1085, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2038, 2, 1086, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2039, 2, 1087, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2040, 2, 1088, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2041, 2, 1089, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2042, 2, 1091, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2043, 2, 1092, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2044, 2, 1095, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2045, 2, 1096, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2046, 2, 1097, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2047, 2, 1098, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2048, 2, 1101, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2049, 2, 1102, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2050, 2, 1103, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2051, 2, 1104, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2052, 2, 1105, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2053, 2, 1106, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2054, 2, 1108, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2055, 2, 1109, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2061, 2, 1127, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2062, 2, 1128, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2063, 2, 1129, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2064, 2, 1130, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2066, 2, 1132, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2067, 2, 1133, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2068, 2, 1134, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2069, 2, 1135, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2070, 2, 1136, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2071, 2, 1137, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2072, 2, 114, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2073, 2, 1139, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2074, 2, 115, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2075, 2, 1140, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2076, 2, 116, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2077, 2, 1141, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2078, 2, 1142, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2079, 2, 1143, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2080, 2, 1150, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2081, 2, 1161, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2082, 2, 1162, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2086, 2, 1166, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2087, 2, 1173, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2088, 2, 1174, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2092, 2, 1178, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2099, 2, 1226, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2100, 2, 1227, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2101, 2, 1228, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2102, 2, 1229, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2103, 2, 1237, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2104, 2, 1238, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2105, 2, 1239, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2106, 2, 1240, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2107, 2, 1241, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2108, 2, 1242, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2109, 2, 1243, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2116, 2, 1254, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2117, 2, 1255, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2118, 2, 1256, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2119, 2, 1257, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2120, 2, 1258, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2121, 2, 1259, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2122, 2, 1260, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2123, 2, 1261, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2124, 2, 1263, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2125, 2, 1264, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2126, 2, 1265, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2127, 2, 1266, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2128, 2, 1267, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2129, 2, 1001, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2130, 2, 1002, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2131, 2, 1003, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2132, 2, 1004, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2133, 2, 1005, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2134, 2, 1006, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2135, 2, 1007, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2136, 2, 1008, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2137, 2, 1009, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2138, 2, 1010, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2139, 2, 1011, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2140, 2, 1012, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2141, 2, 1013, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2143, 2, 1015, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2145, 2, 1017, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2146, 2, 1018, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2147, 2, 1019, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2148, 2, 1020, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2149, 2, 1021, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2150, 2, 1022, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2151, 2, 1023, N'1', N'2023-01-25 08:42:52', N'1', N'2023-01-25 08:42:52', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2152, 2, 1281, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2153, 2, 1282, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2154, 2, 2000, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2155, 2, 2002, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2156, 2, 2003, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2157, 2, 2004, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2158, 2, 2005, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2159, 2, 2006, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2160, 2, 2008, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2161, 2, 2009, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2162, 2, 2010, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2163, 2, 2011, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2164, 2, 2012, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2170, 2, 2019, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2171, 2, 2020, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2172, 2, 2021, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2173, 2, 2022, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2174, 2, 2023, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2175, 2, 2025, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2177, 2, 2027, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2178, 2, 2028, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2179, 2, 2029, N'1', N'2023-01-25 08:42:58', N'1', N'2023-01-25 08:42:58', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2180, 2, 2014, N'1', N'2023-01-25 08:43:12', N'1', N'2023-01-25 08:43:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2181, 2, 2015, N'1', N'2023-01-25 08:43:12', N'1', N'2023-01-25 08:43:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2182, 2, 2016, N'1', N'2023-01-25 08:43:12', N'1', N'2023-01-25 08:43:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2183, 2, 2017, N'1', N'2023-01-25 08:43:12', N'1', N'2023-01-25 08:43:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2184, 2, 2018, N'1', N'2023-01-25 08:43:12', N'1', N'2023-01-25 08:43:12', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2188, 101, 1024, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2189, 101, 1, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2190, 101, 1025, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2191, 101, 1026, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2192, 101, 1027, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2193, 101, 1028, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2194, 101, 1029, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2195, 101, 1030, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2196, 101, 1036, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2197, 101, 1037, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2198, 101, 1038, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2199, 101, 1039, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2200, 101, 1040, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2201, 101, 1042, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2202, 101, 1043, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2203, 101, 1045, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2204, 101, 1046, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2205, 101, 1048, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2206, 101, 2083, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2207, 101, 1063, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2208, 101, 1064, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2209, 101, 1065, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2210, 101, 1093, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2211, 101, 1094, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2212, 101, 1095, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2213, 101, 1096, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2214, 101, 1097, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2215, 101, 1098, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2216, 101, 1100, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2217, 101, 1101, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2218, 101, 1102, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2219, 101, 1103, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2220, 101, 1104, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2221, 101, 1105, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2222, 101, 1106, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2223, 101, 2130, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2224, 101, 1107, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2225, 101, 2131, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2226, 101, 1108, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2227, 101, 2132, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2228, 101, 1109, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2229, 101, 2133, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2230, 101, 2134, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2232, 101, 2135, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2234, 101, 2136, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2236, 101, 2137, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2238, 101, 2138, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2240, 101, 2139, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2242, 101, 2140, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2243, 101, 2141, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2244, 101, 2142, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2245, 101, 2143, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2246, 101, 2144, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2247, 101, 2145, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2248, 101, 2146, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2249, 101, 2147, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2250, 101, 100, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2251, 101, 2148, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2252, 101, 101, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2253, 101, 2149, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2254, 101, 102, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2255, 101, 2150, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2256, 101, 103, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2257, 101, 2151, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2258, 101, 104, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2259, 101, 2152, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2260, 101, 105, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2261, 101, 107, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2262, 101, 108, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2263, 101, 109, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2264, 101, 1138, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2265, 101, 1139, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2266, 101, 1140, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2267, 101, 1141, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2268, 101, 1142, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2269, 101, 1143, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2270, 101, 1224, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2271, 101, 1225, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2272, 101, 1226, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2273, 101, 1227, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2274, 101, 1228, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2275, 101, 1229, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2282, 101, 1261, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2283, 101, 1263, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2284, 101, 1264, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2285, 101, 1265, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2286, 101, 1266, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2287, 101, 1267, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2288, 101, 1001, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2289, 101, 1002, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2290, 101, 1003, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2291, 101, 1004, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2292, 101, 1005, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2293, 101, 1006, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2294, 101, 1007, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2295, 101, 1008, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2296, 101, 1009, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2297, 101, 1010, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2298, 101, 1011, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2299, 101, 1012, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2300, 101, 500, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2301, 101, 1013, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2302, 101, 501, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2303, 101, 1014, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2304, 101, 1015, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2305, 101, 1016, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2306, 101, 1017, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2307, 101, 1018, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2308, 101, 1019, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2309, 101, 1020, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2310, 101, 1021, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2311, 101, 1022, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2312, 101, 1023, N'1', N'2023-02-09 23:49:46', N'1', N'2023-02-09 23:49:46', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2929, 109, 1224, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2930, 109, 1225, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2931, 109, 1226, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2932, 109, 1227, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2933, 109, 1228, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2934, 109, 1229, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2935, 109, 1138, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2936, 109, 1139, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2937, 109, 1140, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2938, 109, 1141, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2939, 109, 1142, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2940, 109, 1143, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2941, 111, 1224, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2942, 111, 1225, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2943, 111, 1226, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2944, 111, 1227, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2945, 111, 1228, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2946, 111, 1229, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2947, 111, 1138, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2948, 111, 1139, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2949, 111, 1140, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2950, 111, 1141, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2951, 111, 1142, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2952, 111, 1143, N'1', N'2023-12-02 23:19:40', N'1', N'2023-12-02 23:19:40', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2993, 109, 2, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2994, 109, 1031, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2995, 109, 1032, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2996, 109, 1033, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2997, 109, 1034, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2998, 109, 1035, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2999, 109, 1050, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3000, 109, 1051, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3001, 109, 1052, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3002, 109, 1053, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3003, 109, 1054, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3004, 109, 1056, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3005, 109, 1057, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3006, 109, 1058, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3007, 109, 1059, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3008, 109, 1060, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3009, 109, 1066, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3010, 109, 1067, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3011, 109, 1070, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3012, 109, 1075, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3014, 109, 1077, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3015, 109, 1078, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3016, 109, 1082, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3017, 109, 1083, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3018, 109, 1084, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3019, 109, 1085, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3020, 109, 1086, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3021, 109, 1087, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3022, 109, 1088, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3023, 109, 1089, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3024, 109, 1090, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3025, 109, 1091, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3026, 109, 1092, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3027, 109, 106, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3028, 109, 110, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3029, 109, 111, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3030, 109, 112, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3031, 109, 113, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3032, 109, 114, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3033, 109, 115, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3034, 109, 116, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3035, 109, 2472, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3036, 109, 2478, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3037, 109, 2479, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3038, 109, 2480, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3039, 109, 2481, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3040, 109, 2482, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3041, 109, 2483, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3042, 109, 2484, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3043, 109, 2485, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3044, 109, 2486, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3045, 109, 2487, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3046, 109, 2488, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3047, 109, 2489, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3048, 109, 2490, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3049, 109, 2491, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3050, 109, 2492, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3051, 109, 2493, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3052, 109, 2494, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3053, 109, 2495, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3054, 109, 2497, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3055, 109, 1237, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3056, 109, 1238, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3057, 109, 1239, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3058, 109, 1240, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3059, 109, 1241, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3060, 109, 1242, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3061, 109, 1243, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3062, 109, 2525, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3063, 109, 1255, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3064, 109, 1256, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3065, 109, 1257, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3066, 109, 1258, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3067, 109, 1259, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3068, 109, 1260, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3069, 111, 2, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3070, 111, 1031, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3071, 111, 1032, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3072, 111, 1033, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3073, 111, 1034, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3074, 111, 1035, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3075, 111, 1050, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3076, 111, 1051, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3077, 111, 1052, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3078, 111, 1053, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3079, 111, 1054, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3080, 111, 1056, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3081, 111, 1057, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3082, 111, 1058, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3083, 111, 1059, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3084, 111, 1060, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3085, 111, 1066, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3086, 111, 1067, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3087, 111, 1070, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3088, 111, 1075, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3090, 111, 1077, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3091, 111, 1078, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3092, 111, 1082, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3093, 111, 1083, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3094, 111, 1084, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3095, 111, 1085, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3096, 111, 1086, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3097, 111, 1087, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3098, 111, 1088, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3099, 111, 1089, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3100, 111, 1090, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3101, 111, 1091, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3102, 111, 1092, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3103, 111, 106, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3104, 111, 110, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3105, 111, 111, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3106, 111, 112, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3107, 111, 113, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3108, 111, 114, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3109, 111, 115, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3110, 111, 116, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3111, 111, 2472, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3112, 111, 2478, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3113, 111, 2479, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3114, 111, 2480, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3115, 111, 2481, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3116, 111, 2482, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3117, 111, 2483, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3118, 111, 2484, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3119, 111, 2485, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3120, 111, 2486, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3121, 111, 2487, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3122, 111, 2488, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3123, 111, 2489, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3124, 111, 2490, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3125, 111, 2491, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3126, 111, 2492, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3127, 111, 2493, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3128, 111, 2494, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3129, 111, 2495, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3130, 111, 2497, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3131, 111, 1237, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3132, 111, 1238, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3133, 111, 1239, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3134, 111, 1240, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3135, 111, 1241, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3136, 111, 1242, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3137, 111, 1243, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3138, 111, 2525, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3139, 111, 1255, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3140, 111, 1256, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3141, 111, 1257, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3142, 111, 1258, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3143, 111, 1259, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3144, 111, 1260, N'1', N'2023-12-02 23:41:02', N'1', N'2023-12-02 23:41:02', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3221, 109, 102, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3222, 109, 1013, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3223, 109, 1014, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3224, 109, 1015, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3225, 109, 1016, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3226, 111, 102, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3227, 111, 1013, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3228, 111, 1014, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3229, 111, 1015, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3230, 111, 1016, N'1', N'2023-12-30 11:42:36', N'1', N'2023-12-30 11:42:36', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4163, 109, 5, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4164, 109, 1118, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4165, 109, 1119, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4166, 109, 1120, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4167, 109, 2713, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4168, 109, 2714, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4169, 109, 2715, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4170, 109, 2716, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4171, 109, 2717, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4172, 109, 2718, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4173, 109, 2720, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4174, 109, 1185, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4175, 109, 2721, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4176, 109, 1186, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4177, 109, 2722, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4178, 109, 1187, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4179, 109, 2723, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4180, 109, 1188, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4181, 109, 2724, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4182, 109, 1189, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4183, 109, 2725, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4184, 109, 1190, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4185, 109, 2726, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4186, 109, 1191, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4187, 109, 2727, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4188, 109, 1192, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4189, 109, 2728, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4190, 109, 1193, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4191, 109, 2729, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4192, 109, 1194, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4193, 109, 2730, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4194, 109, 1195, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4195, 109, 2731, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4196, 109, 1196, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4197, 109, 2732, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4198, 109, 1197, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4199, 109, 2733, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4200, 109, 1198, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4201, 109, 2734, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4202, 109, 1199, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4203, 109, 2735, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4204, 109, 1200, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4205, 109, 1201, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4206, 109, 1202, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4207, 109, 1207, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4208, 109, 1208, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4209, 109, 1209, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4210, 109, 1210, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4211, 109, 1211, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4212, 109, 1212, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4213, 109, 1213, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4214, 109, 1215, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4215, 109, 1216, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4216, 109, 1217, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4217, 109, 1218, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4218, 109, 1219, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4219, 109, 1220, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4220, 109, 1221, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4221, 109, 1222, N'1', N'2024-03-30 17:53:17', N'1', N'2024-03-30 17:53:17', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4222, 111, 5, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4223, 111, 1118, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4224, 111, 1119, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4225, 111, 1120, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4226, 111, 2713, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4227, 111, 2714, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4228, 111, 2715, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4229, 111, 2716, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4230, 111, 2717, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4231, 111, 2718, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4232, 111, 2720, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4233, 111, 1185, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4234, 111, 2721, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4235, 111, 1186, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4236, 111, 2722, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4237, 111, 1187, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4238, 111, 2723, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4239, 111, 1188, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4240, 111, 2724, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4241, 111, 1189, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4242, 111, 2725, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4243, 111, 1190, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4244, 111, 2726, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4245, 111, 1191, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4246, 111, 2727, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4247, 111, 1192, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4248, 111, 2728, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4249, 111, 1193, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4250, 111, 2729, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4251, 111, 1194, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4252, 111, 2730, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4253, 111, 1195, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4254, 111, 2731, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4255, 111, 1196, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4256, 111, 2732, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4257, 111, 1197, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4258, 111, 2733, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4259, 111, 1198, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4260, 111, 2734, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4261, 111, 1199, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4262, 111, 2735, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4263, 111, 1200, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4264, 111, 1201, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4265, 111, 1202, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4266, 111, 1207, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4267, 111, 1208, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4268, 111, 1209, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4269, 111, 1210, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4270, 111, 1211, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4271, 111, 1212, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4272, 111, 1213, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4273, 111, 1215, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4274, 111, 1216, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4275, 111, 1217, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4276, 111, 1218, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4277, 111, 1219, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4278, 111, 1220, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4279, 111, 1221, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4280, 111, 1222, N'1', N'2024-03-30 17:53:18', N'1', N'2024-03-30 17:53:18', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5777, 101, 2739, N'1', N'2024-04-30 09:38:37', N'1', N'2024-04-30 09:38:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5778, 101, 2740, N'1', N'2024-04-30 09:38:37', N'1', N'2024-04-30 09:38:37', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5779, 2, 2739, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5780, 2, 2740, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5781, 2, 2758, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5782, 2, 2759, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5783, 2, 2362, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5784, 2, 2387, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5785, 2, 2030, N'1', N'2024-07-07 20:39:38', N'1', N'2024-07-07 20:39:38', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5786, 101, 2758, N'1', N'2024-07-07 20:39:55', N'1', N'2024-07-07 20:39:55', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5787, 101, 2759, N'1', N'2024-07-07 20:39:55', N'1', N'2024-07-07 20:39:55', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5788, 101, 2783, N'1', N'2024-07-07 20:39:55', N'1', N'2024-07-07 20:39:55', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5789, 109, 2739, N'1', N'2024-07-13 22:37:24', N'1', N'2024-07-13 22:37:24', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5790, 109, 2740, N'1', N'2024-07-13 22:37:24', N'1', N'2024-07-13 22:37:24', N'0', 121)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5791, 111, 2739, N'1', N'2024-07-13 22:37:24', N'1', N'2024-07-13 22:37:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5792, 111, 2740, N'1', N'2024-07-13 22:37:24', N'1', N'2024-07-13 22:37:24', N'0', 122)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6053, 155, 4000, N'1', N'2025-04-01 13:48:26', N'1', N'2025-04-01 13:48:26', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6097, 155, 4050, N'1', N'2025-04-01 13:48:26', N'1', N'2025-04-01 13:48:26', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6104, 155, 4032, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6105, 155, 4033, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6106, 155, 4034, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6107, 155, 4035, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6108, 155, 4036, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6109, 155, 4037, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6110, 155, 4038, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6111, 155, 4039, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6112, 155, 4040, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6113, 155, 4041, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6114, 155, 4042, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6115, 155, 4043, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6116, 155, 4044, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6117, 155, 4045, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6118, 155, 4046, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6119, 155, 4001, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6120, 155, 4002, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6121, 155, 4003, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6122, 155, 4004, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6123, 155, 4005, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6124, 155, 4006, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6125, 155, 4007, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6126, 155, 4008, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6127, 155, 4009, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6128, 155, 4010, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6129, 155, 4011, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6130, 155, 4012, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6131, 155, 4013, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6132, 155, 4014, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6133, 155, 4015, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6134, 155, 4016, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6135, 155, 4017, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6136, 155, 4018, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6137, 155, 4031, N'1', N'2025-04-01 13:49:30', N'1', N'2025-04-01 13:49:30', N'0', 1)
GO
INSERT INTO system_role_menu (id, role_id, menu_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6138, 101, 5010, N'1', N'2025-05-05 17:49:17', N'1', N'2025-05-05 17:49:17', N'0', 1)
GO
SET IDENTITY_INSERT system_role_menu OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_sms_channel
-- ----------------------------
DROP TABLE IF EXISTS system_sms_channel
GO
CREATE TABLE system_sms_channel
(
    id           bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    signature    nvarchar(12)                            NOT NULL,
    code         nvarchar(63)                            NOT NULL,
    status       tinyint                                 NOT NULL,
    remark       nvarchar(255) DEFAULT NULL              NULL,
    api_key      nvarchar(128)                           NOT NULL,
    api_secret   nvarchar(128) DEFAULT NULL              NULL,
    callback_url nvarchar(255) DEFAULT NULL              NULL,
    creator      nvarchar(64)  DEFAULT ''                NULL,
    create_time  datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater      nvarchar(64)  DEFAULT ''                NULL,
    update_time  datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted      bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊绛惧悕',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel',
     'COLUMN', N'signature'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'娓犻亾缂栫爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel',
     'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮€鍚姸鎬?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶囨敞',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel',
     'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊 API 鐨勮处鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel',
     'COLUMN', N'api_key'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊 API 鐨勭閽?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel',
     'COLUMN', N'api_secret'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊鍙戦€佸洖璋?URL',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel',
     'COLUMN', N'callback_url'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊娓犻亾',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_channel'
GO

-- ----------------------------
-- Records of system_sms_channel
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_sms_channel ON
GO
INSERT INTO system_sms_channel (id, signature, code, status, remark, api_key, api_secret, callback_url, creator, create_time, updater, update_time, deleted) VALUES (2, N'Ballcat', N'ALIYUN', 0, N'浣犺鏀瑰摝锛屽彧鏈夋垜鍙互鐢紒锛侊紒锛?, N'ALIYUN_SMS_KEY_PLACEHOLDER', N'ALIYUN_SMS_SECRET_PLACEHOLDER', NULL, N'', N'2021-03-31 11:53:10', N'1', N'2024-08-04 08:53:26', N'0')
GO
INSERT INTO system_sms_channel (id, signature, code, status, remark, api_key, api_secret, callback_url, creator, create_time, updater, update_time, deleted) VALUES (4, N'娴嬭瘯娓犻亾', N'DEBUG_DING_TALK', 0, N'123', N'DEBUG_DING_KEY_PLACEHOLDER', N'DEBUG_DING_SECRET_PLACEHOLDER', NULL, N'1', N'2021-04-13 00:23:14', N'1', N'2022-03-27 20:29:49', N'0')
GO
INSERT INTO system_sms_channel (id, signature, code, status, remark, api_key, api_secret, callback_url, creator, create_time, updater, update_time, deleted) VALUES (7, N'mock鑵捐浜?, N'TENCENT', 0, N'', N'1 2', N'2 3', N'', N'1', N'2024-09-30 08:53:45', N'1', N'2024-09-30 08:55:01', N'0')
GO
SET IDENTITY_INSERT system_sms_channel OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_sms_code
-- ----------------------------
DROP TABLE IF EXISTS system_sms_code
GO
CREATE TABLE system_sms_code
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    mobile      nvarchar(11)                            NOT NULL,
    code        nvarchar(6)                             NOT NULL,
    create_ip   nvarchar(15)                            NOT NULL,
    scene       tinyint                                 NOT NULL,
    today_index tinyint                                 NOT NULL,
    used        tinyint                                 NOT NULL,
    used_time   datetime2     DEFAULT NULL              NULL,
    used_ip     nvarchar(255) DEFAULT NULL              NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL,
    tenant_id   bigint        DEFAULT 0                 NOT NULL
)
GO

CREATE INDEX idx_system_sms_code_01 ON system_sms_code (mobile)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎵嬫満鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'mobile'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'楠岃瘉鐮?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓 IP',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'create_ip'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙戦€佸満鏅?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'scene'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'浠婃棩鍙戦€佺殑绗嚑鏉?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'today_index'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁浣跨敤',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'used'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'浣跨敤鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'used_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'浣跨敤 IP',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'used_ip'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎵嬫満楠岃瘉鐮?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_code'
GO

-- ----------------------------
-- Table structure for system_sms_log
-- ----------------------------
DROP TABLE IF EXISTS system_sms_log
GO
CREATE TABLE system_sms_log
(
    id               bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    channel_id       bigint                                  NOT NULL,
    channel_code     nvarchar(63)                            NOT NULL,
    template_id      bigint                                  NOT NULL,
    template_code    nvarchar(63)                            NOT NULL,
    template_type    tinyint                                 NOT NULL,
    template_content nvarchar(255)                           NOT NULL,
    template_params  nvarchar(255)                           NOT NULL,
    api_template_id  nvarchar(63)                            NOT NULL,
    mobile           nvarchar(11)                            NOT NULL,
    user_id          bigint        DEFAULT NULL              NULL,
    user_type        tinyint       DEFAULT NULL              NULL,
    send_status      tinyint       DEFAULT 0                 NOT NULL,
    send_time        datetime2     DEFAULT NULL              NULL,
    api_send_code    nvarchar(63)  DEFAULT NULL              NULL,
    api_send_msg     nvarchar(255) DEFAULT NULL              NULL,
    api_request_id   nvarchar(255) DEFAULT NULL              NULL,
    api_serial_no    nvarchar(255) DEFAULT NULL              NULL,
    receive_status   tinyint       DEFAULT 0                 NOT NULL,
    receive_time     datetime2     DEFAULT NULL              NULL,
    api_receive_code nvarchar(63)  DEFAULT NULL              NULL,
    api_receive_msg  nvarchar(255) DEFAULT NULL              NULL,
    creator          nvarchar(64)  DEFAULT ''                NULL,
    create_time      datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater          nvarchar(64)  DEFAULT ''                NULL,
    update_time      datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted          bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊娓犻亾缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'channel_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊娓犻亾缂栫爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'channel_code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'template_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘缂栫爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'template_code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'template_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊鍐呭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'template_content'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊鍙傛暟',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'template_params'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊 API 鐨勬ā鏉跨紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'api_template_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎵嬫満鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'mobile'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙戦€佺姸鎬?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'send_status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙戦€佹椂闂?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'send_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊 API 鍙戦€佺粨鏋滅殑缂栫爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'api_send_code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊 API 鍙戦€佸け璐ョ殑鎻愮ず',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'api_send_msg'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊 API 鍙戦€佽繑鍥炵殑鍞竴璇锋眰 ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'api_request_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊 API 鍙戦€佽繑鍥炵殑搴忓彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'api_serial_no'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎺ユ敹鐘舵€?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'receive_status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎺ユ敹鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'receive_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'API 鎺ユ敹缁撴灉鐨勭紪鐮?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'api_receive_code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'API 鎺ユ敹缁撴灉鐨勮鏄?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'api_receive_msg'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊鏃ュ織',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_log'
GO

-- ----------------------------
-- Table structure for system_sms_template
-- ----------------------------
DROP TABLE IF EXISTS system_sms_template
GO
CREATE TABLE system_sms_template
(
    id              bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    type            tinyint                                 NOT NULL,
    status          tinyint                                 NOT NULL,
    code            nvarchar(63)                            NOT NULL,
    name            nvarchar(63)                            NOT NULL,
    content         nvarchar(255)                           NOT NULL,
    params          nvarchar(255)                           NOT NULL,
    remark          nvarchar(255) DEFAULT NULL              NULL,
    api_template_id nvarchar(63)                            NOT NULL,
    channel_id      bigint                                  NOT NULL,
    channel_code    nvarchar(63)                            NOT NULL,
    creator         nvarchar(64)  DEFAULT ''                NULL,
    create_time     datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater         nvarchar(64)  DEFAULT ''                NULL,
    update_time     datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted         bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'寮€鍚姸鎬?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘缂栫爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘鍚嶇О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'妯℃澘鍐呭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'content'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍙傛暟鏁扮粍',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'params'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶囨敞',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊 API 鐨勬ā鏉跨紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'api_template_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊娓犻亾缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'channel_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊娓犻亾缂栫爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'channel_code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐭俊妯℃澘',
     'SCHEMA', N'dbo',
     'TABLE', N'system_sms_template'
GO

-- ----------------------------
-- Records of system_sms_template
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_sms_template ON
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (2, 1, 0, N'test_01', N'娴嬭瘯楠岃瘉鐮佺煭淇?, N'姝ｅ湪杩涜鐧诲綍鎿嶄綔{operation}锛屾偍鐨勯獙璇佺爜鏄瘂code}', N'["operation","code"]', N'娴嬭瘯澶囨敞', N'4383920', 4, N'DEBUG_DING_TALK', N'', N'2021-03-31 10:49:38', N'1', N'2024-08-18 11:57:18', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (3, 1, 0, N'test_02', N'鍏憡閫氱煡', N'鎮ㄧ殑楠岃瘉鐮亄code}锛岃楠岃瘉鐮?鍒嗛挓鍐呮湁鏁堬紝璇峰嬁娉勬紡浜庝粬浜猴紒', N'["code"]', NULL, N'SMS_207945135', 2, N'ALIYUN', N'', N'2021-03-31 11:56:30', N'1', N'2021-04-10 01:22:02', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (6, 3, 0, N'test-01', N'娴嬭瘯妯℃澘', N'鍝堝搱鍝?{name}', N'["name"]', N'f鍝堝搱鍝?, N'4383920', 4, N'DEBUG_DING_TALK', N'1', N'2021-04-10 01:07:21', N'1', N'2024-08-18 11:57:07', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (7, 3, 0, N'test-04', N'娴嬭瘯涓?, N'鑰侀浮{name}锛岀墰閫納code}', N'["name","code"]', N'鍝堝搱鍝堝搱', N'suibian', 7, N'DEBUG_DING_TALK', N'1', N'2021-04-13 00:29:53', N'1', N'2024-09-30 00:56:24', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (8, 1, 0, N'user-sms-login', N'鍓嶅彴鐢ㄦ埛鐭俊鐧诲綍', N'鎮ㄧ殑楠岃瘉鐮佹槸{code}', N'["code"]', NULL, N'4372216', 4, N'DEBUG_DING_TALK', N'1', N'2021-10-11 08:10:00', N'1', N'2024-08-18 11:57:06', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (9, 2, 0, N'bpm_task_assigned', N'銆愬伐浣滄祦銆戜换鍔¤鍒嗛厤', N'鎮ㄦ敹鍒颁簡涓€鏉℃柊鐨勫緟鍔炰换鍔★細{processInstanceName}-{taskName}锛岀敵璇蜂汉锛歿startUserNickname}锛屽鐞嗛摼鎺ワ細{detailUrl}', N'["processInstanceName","taskName","startUserNickname","detailUrl"]', NULL, N'suibian', 4, N'DEBUG_DING_TALK', N'1', N'2022-01-21 22:31:19', N'1', N'2022-01-22 00:03:36', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (10, 2, 0, N'bpm_process_instance_reject', N'銆愬伐浣滄祦銆戞祦绋嬭涓嶉€氳繃', N'鎮ㄧ殑娴佺▼琚鎵逛笉閫氳繃锛歿processInstanceName}锛屽師鍥狅細{reason}锛屾煡鐪嬮摼鎺ワ細{detailUrl}', N'["processInstanceName","reason","detailUrl"]', NULL, N'suibian', 4, N'DEBUG_DING_TALK', N'1', N'2022-01-22 00:03:31', N'1', N'2022-05-01 12:33:14', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (11, 2, 0, N'bpm_process_instance_approve', N'銆愬伐浣滄祦銆戞祦绋嬭閫氳繃', N'鎮ㄧ殑娴佺▼琚鎵归€氳繃锛歿processInstanceName}锛屾煡鐪嬮摼鎺ワ細{detailUrl}', N'["processInstanceName","detailUrl"]', NULL, N'suibian', 4, N'DEBUG_DING_TALK', N'1', N'2022-01-22 00:04:31', N'1', N'2022-03-27 20:32:21', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (12, 2, 0, N'demo', N'婕旂ず妯℃澘', N'鎴戝氨鏄祴璇曚竴涓嬩笅', N'[]', NULL, N'biubiubiu', 4, N'DEBUG_DING_TALK', N'1', N'2022-04-10 23:22:49', N'1', N'2024-08-18 11:57:04', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (14, 1, 0, N'user-update-mobile', N'浼氬憳鐢ㄦ埛 - 淇敼鎵嬫満', N'鎮ㄧ殑楠岃瘉鐮亄code}锛岃楠岃瘉鐮?5 鍒嗛挓鍐呮湁鏁堬紝璇峰嬁娉勬紡浜庝粬浜猴紒', N'["code"]', N'', N'null', 4, N'DEBUG_DING_TALK', N'1', N'2023-08-19 18:58:01', N'1', N'2023-08-19 11:34:04', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (15, 1, 0, N'user-update-password', N'浼氬憳鐢ㄦ埛 - 淇敼瀵嗙爜', N'鎮ㄧ殑楠岃瘉鐮亄code}锛岃楠岃瘉鐮?5 鍒嗛挓鍐呮湁鏁堬紝璇峰嬁娉勬紡浜庝粬浜猴紒', N'["code"]', N'', N'null', 4, N'DEBUG_DING_TALK', N'1', N'2023-08-19 18:58:01', N'1', N'2023-08-19 11:34:18', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (16, 1, 0, N'user-reset-password', N'浼氬憳鐢ㄦ埛 - 閲嶇疆瀵嗙爜', N'鎮ㄧ殑楠岃瘉鐮亄code}锛岃楠岃瘉鐮?5 鍒嗛挓鍐呮湁鏁堬紝璇峰嬁娉勬紡浜庝粬浜猴紒', N'["code"]', N'', N'null', 4, N'DEBUG_DING_TALK', N'1', N'2023-08-19 18:58:01', N'1', N'2023-12-02 22:35:27', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (17, 2, 0, N'bpm_task_timeout', N'銆愬伐浣滄祦銆戜换鍔″鎵硅秴鏃?, N'鎮ㄦ敹鍒颁簡涓€鏉¤秴鏃剁殑寰呭姙浠诲姟锛歿processInstanceName}-{taskName}锛屽鐞嗛摼鎺ワ細{detailUrl}', N'["processInstanceName","taskName","detailUrl"]', N'', N'X', 4, N'DEBUG_DING_TALK', N'1', N'2024-08-16 21:59:15', N'1', N'2024-08-16 21:59:34', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (18, 1, 0, N'admin-reset-password', N'鍚庡彴鐢ㄦ埛 - 蹇樿瀵嗙爜', N'鎮ㄧ殑楠岃瘉鐮亄code}锛岃楠岃瘉鐮?5 鍒嗛挓鍐呮湁鏁堬紝璇峰嬁娉勬紡浜庝粬浜猴紒', N'["code"]', N'', N'null', 4, N'DEBUG_DING_TALK', N'1', N'2025-03-16 14:19:34', N'1', N'2025-03-16 14:19:45', N'0')
GO
INSERT INTO system_sms_template (id, type, status, code, name, content, params, remark, api_template_id, channel_id, channel_code, creator, create_time, updater, update_time, deleted) VALUES (19, 1, 0, N'admin-sms-login', N'鍚庡彴鐢ㄦ埛鐭俊鐧诲綍', N'鎮ㄧ殑楠岃瘉鐮佹槸{code}', N'["code"]', N'', N'4372216', 4, N'DEBUG_DING_TALK', N'1', N'2025-04-08 09:36:03', N'1', N'2025-04-08 09:36:17', N'0')
GO
SET IDENTITY_INSERT system_sms_template OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_social_client
-- ----------------------------
DROP TABLE IF EXISTS system_social_client
GO
CREATE TABLE system_social_client
(
    id            bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name          nvarchar(255)                           NOT NULL,
    social_type   tinyint                                 NOT NULL,
    user_type     tinyint                                 NOT NULL,
    client_id     nvarchar(255)                           NOT NULL,
    client_secret nvarchar(2048)                           NOT NULL,
    public_key    nvarchar(2048) DEFAULT NULL              NULL,
    agent_id      nvarchar(255) DEFAULT NULL              NULL,
    status        tinyint                                 NOT NULL,
    creator       nvarchar(64)  DEFAULT ''                NULL,
    create_time   datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater       nvarchar(64)  DEFAULT ''                NULL,
    update_time   datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted       bit           DEFAULT 0                 NOT NULL,
    tenant_id     bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'搴旂敤鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绀句氦骞冲彴鐨勭被鍨?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'social_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀹㈡埛绔紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀹㈡埛绔瘑閽?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'client_secret'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'publicKey鍏挜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'public_key'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'浠ｇ悊缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'agent_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐘舵€?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绀句氦瀹㈡埛绔〃',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_client'
GO

-- ----------------------------
-- Records of system_social_client
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_social_client ON
GO
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, N'閽夐拤', 20, 2, N'dingvrnreaje3yqvzhxg', N'i8E6iZyDvZj51JIb0tYsYfVQYOks9Cq1lgryEjFRqC79P3iJcrxEwT6Qk2QvLrLI', NULL, 0, N'', N'2023-10-18 11:21:18', N'1', N'2023-12-20 21:28:26', N'1', 1)
GO
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, N'閽夐拤锛堢帇鍦熻眴锛?, 20, 2, N'dingtsu9hpepjkbmthhw', N'FP_bnSq_HAHKCSncmJjw5hxhnzs6vaVDSZZn3egj6rdqTQ_hu5tQVJyLMpgCakdP', NULL, 0, N'', N'2023-10-18 11:21:18', N'', N'2023-12-20 21:28:26', N'1', 121)
GO
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3, N'寰俊鍏紬鍙?, 31, 1, N'wx5b23ba7a5589ecbb', N'2a7b3b20c537e52e74afd395eb85f61f', NULL, 0, N'', N'2023-10-18 16:07:46', N'1', N'2023-12-20 21:28:23', N'1', 1)
GO
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (43, N'寰俊灏忕▼搴?, 34, 1, N'wx63c280fe3248a3e7', N'6f270509224a7ae1296bbf1c8cb97aed', NULL, 0, N'', N'2023-10-19 13:37:41', N'1', N'2023-12-20 21:28:25', N'1', 1)
GO
INSERT INTO system_social_client (id, name, social_type, user_type, client_id, client_secret, agent_id, status, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (44, N'1', 10, 1, N'2', N'3', NULL, 0, N'1', N'2025-04-06 20:36:28', N'1', N'2025-04-06 20:43:12', N'1', 1)
GO
SET IDENTITY_INSERT system_social_client OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_social_user
-- ----------------------------
DROP TABLE IF EXISTS system_social_user
GO
CREATE TABLE system_social_user
(
    id             bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    type           tinyint                                 NOT NULL,
    openid         nvarchar(32)                            NOT NULL,
    token          nvarchar(256) DEFAULT NULL              NULL,
    raw_token_info nvarchar(1024)                          NOT NULL,
    nickname       nvarchar(32)                            NOT NULL,
    avatar         nvarchar(255) DEFAULT NULL              NULL,
    raw_user_info  nvarchar(1024)                          NOT NULL,
    code           nvarchar(256)                           NOT NULL,
    state          nvarchar(256) DEFAULT NULL              NULL,
    creator        nvarchar(64)  DEFAULT ''                NULL,
    create_time    datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater        nvarchar(64)  DEFAULT ''                NULL,
    update_time    datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted        bit           DEFAULT 0                 NOT NULL,
    tenant_id      bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'涓婚敭 ( 鑷绛栫暐)',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绀句氦骞冲彴鐨勭被鍨?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绀句氦 openid',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'openid'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绀句氦 token',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'token'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍘熷 Token 鏁版嵁锛屼竴鑸槸 JSON 鏍煎紡',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'raw_token_info'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛鏄电О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'nickname'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛澶村儚',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'avatar'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍘熷鐢ㄦ埛鏁版嵁锛屼竴鑸槸 JSON 鏍煎紡',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'raw_user_info'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏈€鍚庝竴娆＄殑璁よ瘉 code',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏈€鍚庝竴娆＄殑璁よ瘉 state',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'state'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绀句氦鐢ㄦ埛琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user'
GO

-- ----------------------------
-- Table structure for system_social_user_bind
-- ----------------------------
DROP TABLE IF EXISTS system_social_user_bind
GO
CREATE TABLE system_social_user_bind
(
    id             bigint                                 NOT NULL PRIMARY KEY IDENTITY,
    user_id        bigint                                 NOT NULL,
    user_type      tinyint                                NOT NULL,
    social_type    tinyint                                NOT NULL,
    social_user_id bigint                                 NOT NULL,
    creator        nvarchar(64) DEFAULT ''                NULL,
    create_time    datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater        nvarchar(64) DEFAULT ''                NULL,
    update_time    datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted        bit          DEFAULT 0                 NOT NULL,
    tenant_id      bigint       DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'涓婚敭 ( 鑷绛栫暐)',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user_bind',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user_bind',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛绫诲瀷',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user_bind',
     'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绀句氦骞冲彴鐨勭被鍨?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user_bind',
     'COLUMN', N'social_type'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绀句氦鐢ㄦ埛鐨勭紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user_bind',
     'COLUMN', N'social_user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user_bind',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user_bind',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user_bind',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user_bind',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user_bind',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user_bind',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绀句氦缁戝畾琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_social_user_bind'
GO

-- ----------------------------
-- Table structure for system_tenant
-- ----------------------------
DROP TABLE IF EXISTS system_tenant
GO
CREATE TABLE system_tenant
(
    id              bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name            nvarchar(30)                            NOT NULL,
    contact_user_id bigint        DEFAULT NULL              NULL,
    contact_name    nvarchar(30)                            NOT NULL,
    contact_mobile  nvarchar(500) DEFAULT NULL              NULL,
    status          tinyint       DEFAULT 0                 NOT NULL,
    websites        nvarchar(256) DEFAULT ''                NULL,
    package_id      bigint                                  NOT NULL,
    expire_time     datetime2                               NOT NULL,
    account_count   int                                     NOT NULL,
    creator         nvarchar(64)  DEFAULT ''                NOT NULL,
    create_time     datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater         nvarchar(64)  DEFAULT ''                NULL,
    update_time     datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted         bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑱旂郴浜虹殑鐢ㄦ埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'contact_user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑱旂郴浜?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'contact_name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑱旂郴鎵嬫満',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'contact_mobile'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缁戝畾鍩熷悕',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'website'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛濂楅缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'package_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'杩囨湡鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'expire_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'璐﹀彿鏁伴噺',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'account_count'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant'
GO

-- ----------------------------
-- Records of system_tenant
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_tenant ON
GO
INSERT INTO system_tenant (id, name, contact_user_id, contact_name, contact_mobile, status, websites, package_id, expire_time, account_count, creator, create_time, updater, update_time, deleted) VALUES (1, N'鑺嬮亾婧愮爜', NULL, N'鑺嬭壙', N'17321315478', 0, N'www.iocoder.cn', 0, N'2099-02-19 17:14:16', 9999, N'1', N'2021-01-05 17:03:47', N'1', N'2023-11-06 11:41:41', N'0')
GO
INSERT INTO system_tenant (id, name, contact_user_id, contact_name, contact_mobile, status, websites, package_id, expire_time, account_count, creator, create_time, updater, update_time, deleted) VALUES (121, N'灏忕鎴?, 110, N'灏忕帇2', N'15601691300', 0, N'zsxq.iocoder.cn', 111, N'2026-07-10 00:00:00', 30, N'1', N'2022-02-22 00:56:14', N'1', N'2025-04-03 21:33:01', N'0')
GO
INSERT INTO system_tenant (id, name, contact_user_id, contact_name, contact_mobile, status, websites, package_id, expire_time, account_count, creator, create_time, updater, update_time, deleted) VALUES (122, N'娴嬭瘯绉熸埛', 113, N'鑺嬮亾', N'15601691300', 0, N'test.iocoder.cn', 111, N'2022-04-29 00:00:00', 50, N'1', N'2022-03-07 21:37:58', N'1', N'2024-09-22 12:10:50', N'0')
GO
SET IDENTITY_INSERT system_tenant OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS system_tenant_package
GO
CREATE TABLE system_tenant_package
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name        nvarchar(30)                            NOT NULL,
    status      tinyint       DEFAULT 0                 NOT NULL,
    remark      nvarchar(256) DEFAULT ''                NULL,
    menu_ids    nvarchar(4000)                          NOT NULL,
    creator     nvarchar(64)  DEFAULT ''                NOT NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'濂楅缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant_package',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'濂楅鍚?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant_package',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant_package',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶囨敞',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant_package',
     'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍏宠仈鐨勮彍鍗曠紪鍙?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant_package',
     'COLUMN', N'menu_ids'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant_package',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant_package',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant_package',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant_package',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant_package',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛濂楅琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_tenant_package'
GO

-- ----------------------------
-- Records of system_tenant_package
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_tenant_package ON
GO
INSERT INTO system_tenant_package (id, name, status, remark, menu_ids, creator, create_time, updater, update_time, deleted) VALUES (111, N'鏅€氬椁?, 0, N'灏忓姛鑳?, N'[1,2,5,1031,1032,1033,1034,1035,1036,1037,1038,1039,1050,1051,1052,1053,1054,1056,1057,1058,1059,1060,1063,1064,1065,1066,1067,1070,1075,1077,1078,1082,1083,1084,1085,1086,1087,1088,1089,1090,1091,1092,1118,1119,1120,100,101,102,103,106,107,110,111,112,113,1138,114,1139,115,1140,116,1141,1142,1143,2713,2714,2715,2716,2717,2718,2720,1185,2721,1186,2722,1187,2723,1188,2724,1189,2725,1190,2726,1191,2727,2472,1192,2728,1193,2729,1194,2730,1195,2731,1196,2732,1197,2733,2478,1198,2734,2479,1199,2735,2480,1200,2481,1201,2482,1202,2483,2739,2484,2740,2485,2486,2487,1207,2488,1208,2489,1209,2490,1210,2491,1211,2492,1212,2493,1213,2494,2495,1215,1216,2497,1217,1218,1219,1220,1221,1222,1224,1225,1226,1227,1228,1229,1237,1238,1239,1240,1241,1242,1243,2525,1255,1256,1001,1257,1002,1258,1003,1259,1004,1260,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020]', N'1', N'2022-02-22 00:54:00', N'1', N'2024-07-13 22:37:24', N'0')
GO
INSERT INTO system_tenant_package (id, name, status, remark, menu_ids, creator, create_time, updater, update_time, deleted) VALUES (112, N'鍐嶆潵涓€涓椁?, 0, N'1234', N'[1024,1,1025,1026,2,1027,1028,1029,1030,1031,1032,1033,1034,1035,1036,1037,1038,1039,1040,1042,1043,1045,1046,1048,1050,1051,1052,1053,1054,1056,1057,1058,2083,1059,1060,1063,1064,1065,1066,1067,1070,1075,1077,1078,1082,1083,1084,1085,1086,1087,1088,1089,1090,1091,1092,1093,1094,1095,1096,1097,1098,1100,1101,1102,1103,1104,1105,1106,2130,1107,2131,1108,2132,1109,2133,2134,2135,2136,2137,2138,2139,2140,2141,2142,2143,2144,2145,2146,2147,100,2148,101,2149,102,2150,103,2151,104,2152,105,106,107,108,109,110,111,112,113,1138,114,1139,115,1140,116,1141,1142,1143,2739,2740,1224,1225,1226,1227,1228,1229,1237,1238,1239,1240,1241,1242,1243,1255,1256,1257,1258,1259,1260,1261,1263,1264,1265,1266,1267,2447,2448,2449,2450,2451,2452,2453,2472,2478,2479,2480,2481,2482,2483,2484,2485,2486,2487,2488,2489,2490,2491,2492,2493,2494,2495,2497,2525,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,500,1013,501,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023]', N'1', N'2025-04-04 08:15:02', N'1', N'2025-04-04 08:15:21', N'0')
GO
SET IDENTITY_INSERT system_tenant_package OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_user_post
-- ----------------------------
DROP TABLE IF EXISTS system_user_post
GO
CREATE TABLE system_user_post
(
    id          bigint                                 NOT NULL PRIMARY KEY IDENTITY,
    user_id     bigint       DEFAULT 0                 NOT NULL,
    post_id     bigint       DEFAULT 0                 NOT NULL,
    creator     nvarchar(64) DEFAULT ''                NULL,
    create_time datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64) DEFAULT ''                NULL,
    update_time datetime2    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit          DEFAULT 0                 NOT NULL,
    tenant_id   bigint       DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'id',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_post',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_post',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'宀椾綅ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_post',
     'COLUMN', N'post_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_post',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_post',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_post',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_post',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_post',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_post',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛宀椾綅琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_post'
GO

-- ----------------------------
-- Records of system_user_post
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_user_post ON
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (112, 1, 1, N'admin', N'2022-05-02 07:25:24', N'admin', N'2022-05-02 07:25:24', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (113, 100, 1, N'admin', N'2022-05-02 07:25:24', N'admin', N'2022-05-02 07:25:24', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (115, 104, 1, N'1', N'2022-05-16 19:36:28', N'1', N'2022-05-16 19:36:28', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (116, 117, 2, N'1', N'2022-07-09 17:40:26', N'1', N'2022-07-09 17:40:26', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (117, 118, 1, N'1', N'2022-07-09 17:44:44', N'1', N'2022-07-09 17:44:44', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (119, 114, 5, N'1', N'2024-03-24 20:45:51', N'1', N'2024-03-24 20:45:51', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (123, 115, 1, N'1', N'2024-04-04 09:37:14', N'1', N'2024-04-04 09:37:14', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (124, 115, 2, N'1', N'2024-04-04 09:37:14', N'1', N'2024-04-04 09:37:14', N'0', 1)
GO
INSERT INTO system_user_post (id, user_id, post_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (125, 1, 2, N'1', N'2024-07-13 22:31:39', N'1', N'2024-07-13 22:31:39', N'0', 1)
GO
SET IDENTITY_INSERT system_user_post OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_user_role
-- ----------------------------
DROP TABLE IF EXISTS system_user_role
GO
CREATE TABLE system_user_role
(
    id          bigint                                 NOT NULL PRIMARY KEY IDENTITY,
    user_id     bigint                                 NOT NULL,
    role_id     bigint                                 NOT NULL,
    creator     nvarchar(64) DEFAULT ''                NULL,
    create_time datetime2    DEFAULT CURRENT_TIMESTAMP NULL,
    updater     nvarchar(64) DEFAULT ''                NULL,
    update_time datetime2    DEFAULT CURRENT_TIMESTAMP NULL,
    deleted     bit          DEFAULT 0                 NOT NULL,
    tenant_id   bigint       DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鑷缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_role',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_role',
     'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瑙掕壊ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_role',
     'COLUMN', N'role_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_role',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_role',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_role',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_role',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_role',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_role',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛鍜岃鑹插叧鑱旇〃',
     'SCHEMA', N'dbo',
     'TABLE', N'system_user_role'
GO

-- ----------------------------
-- Records of system_user_role
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_user_role ON
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, 1, 1, N'', N'2022-01-11 13:19:45', N'', N'2022-05-12 12:35:17', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, 2, 2, N'', N'2022-01-11 13:19:45', N'', N'2022-05-12 12:35:13', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4, 100, 101, N'', N'2022-01-11 13:19:45', N'', N'2022-05-12 12:35:13', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, 100, 1, N'', N'2022-01-11 13:19:45', N'', N'2022-05-12 12:35:12', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6, 100, 2, N'', N'2022-01-11 13:19:45', N'', N'2022-05-12 12:35:11', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (10, 103, 1, N'1', N'2022-01-11 13:19:45', N'1', N'2022-01-11 13:19:45', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (14, 110, 109, N'1', N'2022-02-22 00:56:14', N'1', N'2022-02-22 00:56:14', N'0', 121)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (15, 111, 110, N'110', N'2022-02-23 13:14:38', N'110', N'2022-02-23 13:14:38', N'0', 121)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (16, 113, 111, N'1', N'2022-03-07 21:37:58', N'1', N'2022-03-07 21:37:58', N'0', 122)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (18, 1, 2, N'1', N'2022-05-12 20:39:29', N'1', N'2022-05-12 20:39:29', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (22, 115, 2, N'1', N'2022-07-21 22:08:30', N'1', N'2022-07-21 22:08:30', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (35, 112, 1, N'1', N'2024-03-15 20:00:24', N'1', N'2024-03-15 20:00:24', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (36, 118, 1, N'1', N'2024-03-17 09:12:08', N'1', N'2024-03-17 09:12:08', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (38, 114, 101, N'1', N'2024-03-24 22:23:03', N'1', N'2024-03-24 22:23:03', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (46, 117, 1, N'1', N'2024-10-02 10:16:11', N'1', N'2024-10-02 10:16:11', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (47, 104, 2, N'1', N'2025-01-04 10:40:33', N'1', N'2025-01-04 10:40:33', N'0', 1)
GO
INSERT INTO system_user_role (id, user_id, role_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (48, 100, 155, N'1', N'2025-04-04 10:41:14', N'1', N'2025-04-04 10:41:14', N'0', 1)
GO
SET IDENTITY_INSERT system_user_role OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for system_users
-- ----------------------------
DROP TABLE IF EXISTS system_users
GO
CREATE TABLE system_users
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    username    nvarchar(30)                            NOT NULL,
    password    nvarchar(100) DEFAULT ''                NOT NULL,
    nickname    nvarchar(30)                            NOT NULL,
    remark      nvarchar(500) DEFAULT NULL              NULL,
    dept_id     bigint        DEFAULT NULL              NULL,
    post_ids    nvarchar(255) DEFAULT NULL              NULL,
    email       nvarchar(50)  DEFAULT ''                NULL,
    mobile      nvarchar(11)  DEFAULT ''                NULL,
    sex         tinyint       DEFAULT 0                 NULL,
    avatar      nvarchar(512) DEFAULT ''                NULL,
    status      tinyint       DEFAULT 0                 NOT NULL,
    login_ip    nvarchar(50)  DEFAULT ''                NULL,
    login_date  datetime2     DEFAULT NULL              NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL,
    tenant_id   bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛璐﹀彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'username'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀵嗙爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'password'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛鏄电О',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'nickname'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶囨敞',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'閮ㄩ棬ID',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'dept_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'宀椾綅缂栧彿鏁扮粍',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'post_ids'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛閭',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'email'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎵嬫満鍙风爜',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'mobile'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛鎬у埆',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'sex'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶村儚鍦板潃',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'avatar'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'甯愬彿鐘舵€侊紙0姝ｅ父 1鍋滅敤锛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏈€鍚庣櫥褰旾P',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'login_ip'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏈€鍚庣櫥褰曟椂闂?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'login_date'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'system_users',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐢ㄦ埛淇℃伅琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'system_users'
GO

-- ----------------------------
-- Records of system_users
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT system_users ON
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, N'admin', N'$2a$04$KljJDa/LK7QfDm0lF5OhuePhlPfjRH3tB2Wu351Uidz.oQGJXevPi', N'鑺嬮亾婧愮爜', N'绠＄悊鍛?, 103, N'[1,2]', N'11aoteman@126.com', N'18818260277', 2, N'http://test.yudao.iocoder.cn/test/20250502/avatar_1746154660449.png', 0, N'0:0:0:0:0:0:0:1', N'2025-05-10 18:03:15', N'admin', N'2021-01-05 17:03:47', NULL, N'2025-05-10 18:03:15', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (100, N'yudao', N'$2a$04$h.aaPKgO.odHepnk5PCsWeEwKdojFWdTItxGKfx1r0e1CSeBzsTJ6', N'鑺嬮亾', N'涓嶈鍚撴垜', 104, N'[1]', N'yudao@iocoder.cn', N'15601691300', 1, NULL, 0, N'0:0:0:0:0:0:0:1', N'2025-04-08 09:36:40', N'', N'2021-01-07 09:07:17', NULL, N'2025-04-21 14:23:08', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (103, N'yuanma', N'$2a$04$fUBSmjKCPYAUmnMzOb6qE.eZCGPhHi1JmAKclODbfS/O7fHOl2bH6', N'婧愮爜', NULL, 106, NULL, N'yuanma@iocoder.cn', N'15601701300', 0, NULL, 0, N'0:0:0:0:0:0:0:1', N'2024-08-11 17:48:12', N'', N'2021-01-13 23:50:35', NULL, N'2025-04-21 14:23:08', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (104, N'test', N'$2a$04$BrwaYn303hjA/6TnXqdGoOLhyHOAA0bVrAFu6.1dJKycqKUnIoRz2', N'娴嬭瘯鍙?, NULL, 107, N'[1,2]', N'111@qq.com', N'15601691200', 1, NULL, 0, N'0:0:0:0:0:0:0:1', N'2025-03-28 20:01:16', N'', N'2021-01-21 02:13:53', NULL, N'2025-04-21 14:23:08', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (107, N'admin107', N'$2a$10$dYOOBKMO93v/.ReCqzyFg.o67Tqk.bbc2bhrpyBGkIw9aypCtr2pm', N'鑺嬭壙', NULL, NULL, NULL, N'', N'15601691300', 0, NULL, 0, N'', NULL, N'1', N'2022-02-20 22:59:33', N'1', N'2025-04-21 14:23:08', N'0', 118)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (108, N'admin108', N'$2a$10$y6mfvKoNYL1GXWak8nYwVOH.kCWqjactkzdoIDgiKl93WN3Ejg.Lu', N'鑺嬭壙', NULL, NULL, NULL, N'', N'15601691300', 0, NULL, 0, N'', NULL, N'1', N'2022-02-20 23:00:50', N'1', N'2025-04-21 14:23:08', N'0', 119)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (109, N'admin109', N'$2a$10$JAqvH0tEc0I7dfDVBI7zyuB4E3j.uH6daIjV53.vUS6PknFkDJkuK', N'鑺嬭壙', NULL, NULL, NULL, N'', N'15601691300', 0, NULL, 0, N'', NULL, N'1', N'2022-02-20 23:11:50', N'1', N'2025-04-21 14:23:08', N'0', 120)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (110, N'admin110', N'$2a$10$mRMIYLDtRHlf6.9ipiqH1.Z.bh/R9dO9d5iHiGYPigi6r5KOoR2Wm', N'灏忕帇', NULL, NULL, NULL, N'', N'15601691300', 0, NULL, 0, N'0:0:0:0:0:0:0:1', N'2024-07-20 22:23:17', N'1', N'2022-02-22 00:56:14', NULL, N'2025-04-21 14:23:08', N'0', 121)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (111, N'test', N'$2a$10$mRMIYLDtRHlf6.9ipiqH1.Z.bh/R9dO9d5iHiGYPigi6r5KOoR2Wm', N'娴嬭瘯鐢ㄦ埛', NULL, NULL, N'[]', N'', N'', 0, NULL, 0, N'0:0:0:0:0:0:0:1', N'2023-12-30 11:42:17', N'110', N'2022-02-23 13:14:33', NULL, N'2025-04-21 14:23:08', N'0', 121)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (112, N'newobject', N'$2a$04$dB0z8Q819fJWz0hbaLe6B.VfHCjYgWx6LFfET5lyz3JwcqlyCkQ4C', N'鏂板璞?, NULL, 100, N'[]', N'', N'15601691235', 1, NULL, 0, N'0:0:0:0:0:0:0:1', N'2024-03-16 23:11:38', N'1', N'2022-02-23 19:08:03', NULL, N'2025-04-21 14:23:08', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (113, N'aoteman', N'$2a$10$0acJOIk2D25/oC87nyclE..0lzeu9DtQ/n3geP4fkun/zIVRhHJIO', N'鑺嬮亾1', NULL, NULL, NULL, N'', N'15601691300', 0, NULL, 0, N'127.0.0.1', N'2022-03-19 18:38:51', N'1', N'2022-03-07 21:37:58', N'1', N'2025-05-05 15:30:53', N'0', 122)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (114, N'hrmgr', N'$2a$10$TR4eybBioGRhBmDBWkqWLO6NIh3mzYa8KBKDDB5woiGYFVlRAi.fu', N'hr 灏忓濮?, NULL, NULL, N'[5]', N'', N'15601691236', 1, NULL, 0, N'0:0:0:0:0:0:0:1', N'2024-03-24 22:21:05', N'1', N'2022-03-19 21:50:58', NULL, N'2025-04-21 14:23:08', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (115, N'aotemane', N'$2a$04$GcyP0Vyzb2F2Yni5PuIK9ueGxM0tkZGMtDwVRwrNbtMvorzbpNsV2', N'闃垮憜', N'11222', 102, N'[1,2]', N'7648@qq.com', N'15601691229', 2, NULL, 0, N'', NULL, N'1', N'2022-04-30 02:55:43', N'1', N'2025-04-21 14:23:08', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (117, N'admin123', N'$2a$04$sEtimsHu9YCkYY4/oqElHem2Ijc9ld20eYO6lN.g/21NfLUTDLB9W', N'娴嬭瘯鍙?2', N'1111', 100, N'[2]', N'', N'15601691234', 1, NULL, 0, N'0:0:0:0:0:0:0:1', N'2024-10-02 10:16:20', N'1', N'2022-07-09 17:40:26', NULL, N'2025-04-21 14:23:08', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (118, N'goudan', N'$2a$04$jth0yOj8cSJq84D6vrzusOHDwW/LpBfgBnQ6bfFlD8zNZfM632Ta2', N'鐙楄泲', NULL, 103, N'[1]', N'', N'15601691239', 1, NULL, 0, N'0:0:0:0:0:0:0:1', N'2024-03-17 09:10:27', N'1', N'2022-07-09 17:44:43', N'1', N'2025-04-21 14:23:08', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (131, N'hh', N'$2a$04$jyH9h6.gaw8mpOjPfHIpx.8as2Rzfcmdlj5rlJFwgCw4rsv/MTb2K', N'鍛靛懙', NULL, 100, N'[]', N'777@qq.com', N'15601882312', 1, NULL, 0, N'', NULL, N'1', N'2024-04-27 08:45:56', N'1', N'2025-04-21 14:23:08', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (139, N'wwbwwb', N'$2a$04$aOHoFbQU6zfBk/1Z9raF/ugTdhjNdx7culC1HhO0zvoczAnahCiMq', N'灏忕澶?, NULL, NULL, NULL, N'', N'', 0, NULL, 0, N'0:0:0:0:0:0:0:1', N'2024-09-10 21:03:58', NULL, N'2024-09-10 21:03:58', NULL, N'2025-04-21 14:23:08', N'0', 1)
GO
INSERT INTO system_users (id, username, password, nickname, remark, dept_id, post_ids, email, mobile, sex, avatar, status, login_ip, login_date, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (141, N'admin1', N'$2a$04$oj6F6d7HrZ70kYVD3TNzEu.m3TPUzajOVuC66zdKna8KRerK1FmVa', N'鏂扮敤鎴?, NULL, NULL, NULL, N'', N'', 0, N'', 0, N'0:0:0:0:0:0:0:1', N'2025-04-08 13:09:07', N'1', N'2025-04-08 13:09:07', N'1', N'2025-04-08 13:09:07', N'0', 1)
GO
SET IDENTITY_INSERT system_users OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for yudao_demo01_contact
-- ----------------------------
DROP TABLE IF EXISTS yudao_demo01_contact
GO
CREATE TABLE yudao_demo01_contact
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name        nvarchar(100) DEFAULT ''                NOT NULL,
    sex         tinyint                                 NOT NULL,
    birthday    datetime2                               NOT NULL,
    description nvarchar(255)                           NOT NULL,
    avatar      nvarchar(512) DEFAULT NULL              NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL,
    tenant_id   bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo01_contact',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍚嶅瓧',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo01_contact',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎬у埆',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo01_contact',
     'COLUMN', N'sex'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍑虹敓骞?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo01_contact',
     'COLUMN', N'birthday'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绠€浠?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo01_contact',
     'COLUMN', N'description'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'澶村儚',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo01_contact',
     'COLUMN', N'avatar'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo01_contact',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo01_contact',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo01_contact',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo01_contact',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo01_contact',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo01_contact',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绀轰緥鑱旂郴浜鸿〃',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo01_contact'
GO

-- ----------------------------
-- Records of yudao_demo01_contact
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT yudao_demo01_contact ON
GO
INSERT INTO yudao_demo01_contact (id, name, sex, birthday, description, avatar, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, N'鍦熻眴', 2, N'2023-11-07 00:00:00', N'<p>澶╄殨鍦熻眴锛佸憖</p>', N'http://127.0.0.1:48080/admin-api/infra/file/4/get/46f8fa1a37db3f3960d8910ff2fe3962ab3b2db87cf2f8ccb4dc8145b8bdf237.jpeg', N'1', N'2023-11-15 23:34:30', N'1', N'2023-11-15 23:47:39', N'0', 1)
GO
SET IDENTITY_INSERT yudao_demo01_contact OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for yudao_demo02_category
-- ----------------------------
DROP TABLE IF EXISTS yudao_demo02_category
GO
CREATE TABLE yudao_demo02_category
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name        nvarchar(100) DEFAULT ''                NOT NULL,
    parent_id   bigint                                  NOT NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL,
    tenant_id   bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo02_category',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍚嶅瓧',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo02_category',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐖剁骇缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo02_category',
     'COLUMN', N'parent_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo02_category',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo02_category',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo02_category',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo02_category',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo02_category',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo02_category',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绀轰緥鍒嗙被琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo02_category'
GO

-- ----------------------------
-- Records of yudao_demo02_category
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT yudao_demo02_category ON
GO
INSERT INTO yudao_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (1, N'鍦熻眴', 0, N'1', N'2023-11-15 23:34:30', N'1', N'2023-11-16 20:24:23', N'0', 1)
GO
INSERT INTO yudao_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, N'鐣寗', 0, N'1', N'2023-11-16 20:24:00', N'1', N'2023-11-16 20:24:15', N'0', 1)
GO
INSERT INTO yudao_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3, N'鎬€?, 0, N'1', N'2023-11-16 20:24:32', N'1', N'2023-11-16 20:24:32', N'0', 1)
GO
INSERT INTO yudao_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (4, N'灏忕暘鑼?, 2, N'1', N'2023-11-16 20:24:39', N'1', N'2023-11-16 20:24:39', N'0', 1)
GO
INSERT INTO yudao_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, N'澶х暘鑼?, 2, N'1', N'2023-11-16 20:24:46', N'1', N'2023-11-16 20:24:46', N'0', 1)
GO
INSERT INTO yudao_demo02_category (id, name, parent_id, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6, N'11', 3, N'1', N'2023-11-24 19:29:34', N'1', N'2023-11-24 19:29:34', N'0', 1)
GO
SET IDENTITY_INSERT yudao_demo02_category OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for yudao_demo03_course
-- ----------------------------
DROP TABLE IF EXISTS yudao_demo03_course
GO
CREATE TABLE yudao_demo03_course
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    student_id  bigint                                  NOT NULL,
    name        nvarchar(100) DEFAULT ''                NOT NULL,
    score       tinyint                                 NOT NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL,
    tenant_id   bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_course',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛︾敓缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_course',
     'COLUMN', N'student_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍚嶅瓧',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_course',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒嗘暟',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_course',
     'COLUMN', N'score'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_course',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_course',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_course',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_course',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_course',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_course',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛︾敓璇剧▼琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_course'
GO

-- ----------------------------
-- Records of yudao_demo03_course
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT yudao_demo03_course ON
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, 2, N'璇枃', 66, N'1', N'2023-11-16 23:21:49', N'1', N'2024-09-17 10:55:30', N'1', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (3, 2, N'鏁板', 22, N'1', N'2023-11-16 23:21:49', N'1', N'2024-09-17 10:55:30', N'1', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (6, 5, N'浣撹偛', 23, N'1', N'2023-11-16 23:22:46', N'1', N'2023-11-16 15:44:40', N'1', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (7, 5, N'璁＄畻鏈?, 11, N'1', N'2023-11-16 23:22:46', N'1', N'2023-11-16 15:44:40', N'1', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (8, 5, N'浣撹偛', 23, N'1', N'2023-11-16 23:22:46', N'1', N'2023-11-16 15:47:09', N'1', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (9, 5, N'璁＄畻鏈?, 11, N'1', N'2023-11-16 23:22:46', N'1', N'2023-11-16 15:47:09', N'1', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (10, 5, N'浣撹偛', 23, N'1', N'2023-11-16 23:22:46', N'1', N'2024-09-17 10:55:28', N'1', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (11, 5, N'璁＄畻鏈?, 11, N'1', N'2023-11-16 23:22:46', N'1', N'2024-09-17 10:55:28', N'1', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (12, 2, N'鐢佃剳', 33, N'1', N'2023-11-17 00:20:42', N'1', N'2023-11-16 16:20:45', N'1', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (13, 9, N'婊戦洩', 12, N'1', N'2023-11-17 13:13:20', N'1', N'2024-09-17 10:55:26', N'1', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (14, 9, N'婊戦洩', 12, N'1', N'2023-11-17 13:13:20', N'1', N'2024-09-17 10:55:49', N'1', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (15, 5, N'浣撹偛', 23, N'1', N'2023-11-16 23:22:46', N'1', N'2024-09-17 18:55:29', N'0', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (16, 5, N'璁＄畻鏈?, 11, N'1', N'2023-11-16 23:22:46', N'1', N'2024-09-17 18:55:29', N'0', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (17, 2, N'璇枃', 66, N'1', N'2023-11-16 23:21:49', N'1', N'2024-09-17 18:55:31', N'0', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (18, 2, N'鏁板', 22, N'1', N'2023-11-16 23:21:49', N'1', N'2024-09-17 18:55:31', N'0', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (19, 9, N'婊戦洩', 12, N'1', N'2023-11-17 13:13:20', N'1', N'2025-04-19 02:49:03', N'1', 1)
GO
INSERT INTO yudao_demo03_course (id, student_id, name, score, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (20, 9, N'婊戦洩', 12, N'1', N'2023-11-17 13:13:20', N'1', N'2025-04-19 10:49:04', N'0', 1)
GO
SET IDENTITY_INSERT yudao_demo03_course OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for yudao_demo03_grade
-- ----------------------------
DROP TABLE IF EXISTS yudao_demo03_grade
GO
CREATE TABLE yudao_demo03_grade
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    student_id  bigint                                  NOT NULL,
    name        nvarchar(100) DEFAULT ''                NOT NULL,
    teacher     nvarchar(255)                           NOT NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL,
    tenant_id   bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_grade',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛︾敓缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_grade',
     'COLUMN', N'student_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍚嶅瓧',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_grade',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鐝富浠?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_grade',
     'COLUMN', N'teacher'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_grade',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_grade',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_grade',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_grade',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_grade',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_grade',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛︾敓鐝骇琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_grade'
GO

-- ----------------------------
-- Records of yudao_demo03_grade
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT yudao_demo03_grade ON
GO
INSERT INTO yudao_demo03_grade (id, student_id, name, teacher, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (7, 2, N'涓夊勾 2 鐝?, N'鍛ㄦ澃浼?, N'1', N'2023-11-16 23:21:49', N'1', N'2024-09-17 18:55:31', N'0', 1)
GO
INSERT INTO yudao_demo03_grade (id, student_id, name, teacher, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (8, 5, N'鍗庝负', N'閬ラ仴棰嗗厛', N'1', N'2023-11-16 23:22:46', N'1', N'2024-09-17 18:55:29', N'0', 1)
GO
INSERT INTO yudao_demo03_grade (id, student_id, name, teacher, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (9, 9, N'灏忓浘', N'灏忓▋111', N'1', N'2023-11-17 13:10:23', N'1', N'2025-04-19 10:49:04', N'0', 1)
GO
SET IDENTITY_INSERT yudao_demo03_grade OFF
GO
COMMIT
GO
-- @formatter:on

-- ----------------------------
-- Table structure for yudao_demo03_student
-- ----------------------------
DROP TABLE IF EXISTS yudao_demo03_student
GO
CREATE TABLE yudao_demo03_student
(
    id          bigint                                  NOT NULL PRIMARY KEY IDENTITY,
    name        nvarchar(100) DEFAULT ''                NOT NULL,
    sex         tinyint                                 NOT NULL,
    birthday    datetime2                               NOT NULL,
    description nvarchar(255)                           NOT NULL,
    creator     nvarchar(64)  DEFAULT ''                NULL,
    create_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updater     nvarchar(64)  DEFAULT ''                NULL,
    update_time datetime2     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted     bit           DEFAULT 0                 NOT NULL,
    tenant_id   bigint        DEFAULT 0                 NOT NULL
)
GO

EXEC sp_addextendedproperty
     'MS_Description', N'缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_student',
     'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍚嶅瓧',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_student',
     'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鎬у埆',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_student',
     'COLUMN', N'sex'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍑虹敓鏃ユ湡',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_student',
     'COLUMN', N'birthday'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绠€浠?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_student',
     'COLUMN', N'description'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_student',
     'COLUMN', N'creator'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鍒涘缓鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_student',
     'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鑰?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_student',
     'COLUMN', N'updater'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏇存柊鏃堕棿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_student',
     'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'鏄惁鍒犻櫎',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_student',
     'COLUMN', N'deleted'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'绉熸埛缂栧彿',
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_student',
     'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
     'MS_Description', N'瀛︾敓琛?,
     'SCHEMA', N'dbo',
     'TABLE', N'yudao_demo03_student'
GO

-- ----------------------------
-- Records of yudao_demo03_student
-- ----------------------------
-- @formatter:off
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT yudao_demo03_student ON
GO
INSERT INTO yudao_demo03_student (id, name, sex, birthday, description, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (2, N'灏忕櫧', 1, N'2023-11-16 00:00:00', N'<p>鍘夊</p>', N'1', N'2023-11-16 23:21:49', N'1', N'2024-09-17 18:55:31', N'0', 1)
GO
INSERT INTO yudao_demo03_student (id, name, sex, birthday, description, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (5, N'澶ч粦', 2, N'2023-11-13 00:00:00', N'<p>浣犲湪鏁欐垜鍋氫簨?</p>', N'1', N'2023-11-16 23:22:46', N'1', N'2024-09-17 18:55:29', N'0', 1)
GO
INSERT INTO yudao_demo03_student (id, name, sex, birthday, description, creator, create_time, updater, update_time, deleted, tenant_id) VALUES (9, N'灏忚姳', 1, N'2023-11-07 00:00:00', N'<p>鍝堝搱鍝?/p>', N'1', N'2023-11-17 00:04:47', N'1', N'2025-04-19 10:49:04', N'0', 1)
GO
SET IDENTITY_INSERT yudao_demo03_student OFF
GO
COMMIT
GO
-- @formatter:on


