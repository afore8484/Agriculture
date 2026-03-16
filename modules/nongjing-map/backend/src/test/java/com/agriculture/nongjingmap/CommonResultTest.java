package com.agriculture.nongjingmap;

import com.agriculture.nongjingmap.common.pojo.CommonResult;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class CommonResultTest {

    @Test
    void successShouldWrapData() {
        CommonResult<String> result = CommonResult.success("ok");
        Assertions.assertEquals(0, result.getCode());
        Assertions.assertEquals("success", result.getMessage());
        Assertions.assertEquals("ok", result.getData());
    }
}