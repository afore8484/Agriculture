package com.agriculture.villagefinance.module.finance.dal.mysql;

import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBankAccountDO;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FinBankAccountMapper extends BaseMapper<FinBankAccountDO> {
}
