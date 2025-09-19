class PayStackDonationData {
  final String facilityId;
  final String donationId;
  final String caseId;
  final String paystackAccessCode;
  final String paystackReference;

  PayStackDonationData({
    this.facilityId = "",
    this.donationId = "",
    this.caseId = "",
    this.paystackAccessCode = "",
    this.paystackReference = "",
  });

  factory PayStackDonationData.fromJson(Map<String, dynamic> json) {
    return PayStackDonationData(
      facilityId: json['facility_id'] ?? '',
      donationId: json['donation_id'] ?? '',
      caseId: json['case_id'] ?? '',
      paystackAccessCode: json['paystack_access_code'] ?? '',
      paystackReference: json['paystack_reference'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'facility_id': facilityId,
      'donation_id': donationId,
      'case_id': caseId,
      'paystack_access_code': paystackAccessCode,
      'paystack_reference': paystackReference,
    };
  }
}


//{status: true, message: donation initialized, data: {paystack_access_code: p7homf32nadznwy, paystack_reference: n21resjvrd, paystack_url: https://checkout.paystack.com/p7homf32nadznwy, donation_id: n21resjvrd, facility_id: HOSPITAL-1036430899-MEDICURE, case_id: CASE-3320c834-7fe5-44d5-8bd2-280493398542}}