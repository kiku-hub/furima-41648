const price = () => {
  // 金額を入力する場所のIDセレクタを指定
  const priceInput = document.getElementById("item-price"); // 入力欄のIDを指定
  const addTaxDom = document.getElementById("add-tax-price"); // 販売手数料を表示する場所のID
  const profitDom = document.getElementById("profit"); // 販売利益を表示する場所のID

  // priceInputが存在するか確認
  if (!priceInput || !addTaxDom || !profitDom) {
    console.error("必要な要素が見つかりません。");
    return; // 要素がない場合は処理を終了
  }

  // 金額入力時のイベントリスナー
  priceInput.addEventListener("input", function() {
    const inputValue = parseFloat(priceInput.value); // 入力された値を取得

    // 有効な数値かどうかをチェック
    if (isNaN(inputValue) || inputValue <= 0) {
      // 無効な場合は表示をクリア
      addTaxDom.innerHTML = "";
      profitDom.innerHTML = "";
      return; // 処理を終了
    }

    // 販売手数料の計算
    const commission = Math.floor(inputValue * 0.1); // 10%の手数料
    addTaxDom.innerHTML = `${commission}`; // HTMLに表示

    // 販売利益の計算
    const profit = Math.floor(inputValue - commission);
    profitDom.innerHTML = `${profit}`; // HTMLに表示
  });
};

// Turboイベントリスナーを設定
document.addEventListener("turbo:load", price);
document.addEventListener("turbo:render", price);