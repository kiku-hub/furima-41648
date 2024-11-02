const pay = () => {
  const payjp = Payjp('pk_test_3753068fde969eb534940b05'); // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // フォームのデフォルトの送信を防ぐ

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        console.error(response.error); // エラー内容をコンソールに表示
        alert(response.error.message); // ユーザーにエラーを知らせる
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value="${token}" name="token" type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);

        // フィールドをクリア
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();

        // フォームを送信
        document.getElementById("charge-form").submit();
      }
    });
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);