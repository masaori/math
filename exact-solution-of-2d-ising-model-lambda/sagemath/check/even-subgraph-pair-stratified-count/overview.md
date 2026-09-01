# SageMath Check: 偶部分グラフ順序対の層別による数え上げ

**対象ラベル**: `claim_even_subgraph_pair_stratified_count`

一辺 $L=2$ の周期正方格子で、偶部分グラフの順序対 $(A,B)$ の母関数
$\sum x^{|A|+|B|}$ が、互いに素で $E$ が偶部分グラフである添字 $(D,E)$ ごとの
選択集合の個数による層別 $\sum|\mathcal C_L(D,E)|\,x^{2|D|+|E|}$ に一致することを
$\mathbb{Z}[x]$ で検査する。証明の各段も全数で検査する:

- 各順序対の像 $(A\cap B,\ A\mathbin\triangle B)$ が添字集合に入ること（互いに素・偶部分グラフ性）、
- 位数の和の等式 $|A|+|B|=2|D|+|E|$、
- 添字ごとのファイバーが $\mathcal P_L(D,E)$ と一致し、互いに素な合併が順序対の全体を尽くすこと、
- $|\mathcal P_L(D,E)|=|\mathcal C_L(D,E)|$（ファイバー全単射の主張の再確認）。

- 実行: `sage sagemath/check/even-subgraph-pair-stratified-count/check.sage`
- 状態: PASS（2026-09-01）
- 結果: 順序対 $1{,}024$ 件、添字 $(D,E)$ は $881$ 組で、両辺は
  $x^{16}+8x^{14}+60x^{12}+184x^{10}+518x^8+184x^6+60x^4+8x^2+1$ に一致した。

すべて有限集合の列挙と $\mathbb{Z}[x]$ の厳密計算であり、浮動小数点は使わない。
