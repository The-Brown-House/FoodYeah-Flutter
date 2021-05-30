class QuoteDetail {
  final int locId;
  final int numberQuotes = 1;
  final int frecuency = 7;
  final String currency = "Soles";
  QuoteDetail(this.locId);

  Map<String, dynamic> toJson() {
    return {
      "locId": this.locId,
      "numberQuotes": this.numberQuotes,
      "frecuency": this.frecuency,
      "currency": this.currency,
    };
  }
}
