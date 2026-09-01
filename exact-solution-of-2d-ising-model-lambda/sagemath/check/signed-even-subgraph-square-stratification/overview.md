# SageMath Check: 符号付き偶部分グラフ多項式の平方の選択集合による層別

**対象ラベル**: `claim_signed_even_subgraph_square_stratified`

$L=2$ のトーラスと四つのスピン構造 $(a,b)$ について、次を `ZZ[x]` で厳密検査する。

- 偶部分グラフ順序対 $(A,B)$ を $(D,E)=(A\cap B,A\mathbin\triangle B)$ で層別できること、
- 選択 $C\in\mathcal C_L(D,E)$ から
  $(A,B)=(D\cup C,D\cup(E\setminus C))$ を復元できること、
- 各順序対の符号積と次数が、符号付き選択和
  $\mathcal U^{a,b}_L(D,E)$ と次数 $2|D|+|E|$ に一致すること、
- 層別した多項式が $(Q^{a,b}_L)^2$ に一致すること。

- 実行: `sage sagemath/check/signed-even-subgraph-square-stratification/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 偶部分グラフ順序対 $1{,}024$ 件を四つのスピン構造すべてで検査した。

計算はすべて整数と整数係数多項式の厳密計算であり、浮動小数点は使わない。
