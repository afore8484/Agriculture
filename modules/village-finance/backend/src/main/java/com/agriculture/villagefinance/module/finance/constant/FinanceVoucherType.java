package com.agriculture.villagefinance.module.finance.constant;

import org.springframework.util.StringUtils;

import java.util.Locale;
import java.util.Set;

public final class FinanceVoucherType {

    public static final String MANUAL = "MANUAL";
    public static final String TRANSFER = "TRANSFER";
    public static final String ASSET_DEPRECIATION = "ASSET_DEPRECIATION";
    public static final String ASSET_DISPOSAL = "ASSET_DISPOSAL";
    public static final String CONTRACT_PAYMENT = "CONTRACT_PAYMENT";
    public static final String CONTRACT_RECEIPT = "CONTRACT_RECEIPT";

    private static final Set<String> ALLOWED_TYPES = Set.of(
            MANUAL,
            TRANSFER,
            ASSET_DEPRECIATION,
            ASSET_DISPOSAL,
            CONTRACT_PAYMENT,
            CONTRACT_RECEIPT
    );

    private static final Set<String> MANAGED_TYPES = Set.of(
            TRANSFER,
            ASSET_DEPRECIATION,
            ASSET_DISPOSAL,
            CONTRACT_PAYMENT,
            CONTRACT_RECEIPT
    );

    private FinanceVoucherType() {
    }

    public static String normalize(String rawType) {
        if (!StringUtils.hasText(rawType)) {
            return MANUAL;
        }
        return rawType.trim().toUpperCase(Locale.ROOT);
    }

    public static void validateAllowed(String normalizedType) {
        if (!ALLOWED_TYPES.contains(normalizedType)) {
            throw new IllegalArgumentException("凭证来源类型不受支持");
        }
    }

    public static boolean isManagedType(String normalizedType) {
        return MANAGED_TYPES.contains(normalizedType);
    }
}
