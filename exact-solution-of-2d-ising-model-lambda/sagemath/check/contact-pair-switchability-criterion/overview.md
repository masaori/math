# SageMath Check: 接触対の切り替え可能性の局所判定

**対象ラベル**: `claim_contact_pair_switchability_criterion`

全非後退置換の全接触対（切り替え可能に限らない）について、切り替え可能性の三条件と、
四つの不等式 $\varphi(\vec f)\ne\iota(\vec e)$、$\varphi(\vec e)\ne\iota(\vec f)$、
$\varphi(\vec f)\ne\vec e$、$\varphi(\vec e)\ne\vec f$ の連言が一致することを検査する。
証明の冒頭が使う等式（動く辺の像の始点は元の辺の終点）も検査する。

- 実行: `sage sagemath/check/contact-pair-switchability-criterion/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 一辺 $L=2$ で接触対 $470{,}336$ 件の全数について判定の一致を確認した
  （切り替え可能 $192{,}896$ 件）。あわせて、標準接触対が切り替え可能でない置換
  $18{,}755$ 個の内訳を数えた: すべて反転像による失敗
  （$\varphi(\vec f)=\iota(\vec e)$ または $\varphi(\vec e)=\iota(\vec f)$）であり、
  像が他方自身に一致する失敗は $0$ 個だった（次のセクションの分類の一次データ）。

計算は有限集合の等号だけで行い、浮動小数点は使わない。
