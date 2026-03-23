package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.ContractAcceptanceCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractAcceptanceRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractAttachmentCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractAttachmentRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractChangeCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractChangeRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractOperationLogRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractPageRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractPaymentCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractPaymentRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractRenewalCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractRenewalRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractTerminationCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractTerminationRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractUpdateReqVO;

import java.util.List;

public interface FinanceContractService {

    ContractRespVO createContract(ContractCreateReqVO reqVO);

    ContractRespVO updateContract(ContractUpdateReqVO reqVO);

    ContractPageRespVO getContractPage(Integer pageNo, Integer pageSize, Long ledgerId,
                                       String contractName, String contractType, String status);

    ContractRespVO getContract(Long contractId);

    void deleteContract(Long contractId, Long operatorId);

    ContractChangeRespVO createChange(ContractChangeCreateReqVO reqVO);

    List<ContractChangeRespVO> getChangeList(Long contractId);

    ContractAcceptanceRespVO createAcceptance(ContractAcceptanceCreateReqVO reqVO);

    List<ContractAcceptanceRespVO> getAcceptanceList(Long contractId);

    ContractPaymentRespVO createReceipt(ContractPaymentCreateReqVO reqVO);

    ContractPaymentRespVO createPayment(ContractPaymentCreateReqVO reqVO);

    List<ContractPaymentRespVO> getPaymentList(Long contractId, String paymentType);

    ContractTerminationRespVO createTermination(ContractTerminationCreateReqVO reqVO);

    List<ContractTerminationRespVO> getTerminationList(Long contractId);

    ContractRenewalRespVO createRenewal(ContractRenewalCreateReqVO reqVO);

    List<ContractRenewalRespVO> getRenewalList(Long contractId);

    ContractAttachmentRespVO createAttachment(ContractAttachmentCreateReqVO reqVO);

    List<ContractAttachmentRespVO> getAttachmentList(Long contractId, String bizType);

    List<ContractOperationLogRespVO> getOperationLogList(Long contractId);
}
