# SageMath Check: 双対な点どうしの自由エントロピーの関係

## 対象

**対象ラベル**: `claim_free_entropy_dual_relation`, `claim_partition_value_dual_factorization`

- 実行日: 2026-08-14
- 結果: $L=1,2,3$ × 有理点 6 個すべて通過（`RESULT: PASS`）
- 帰属: 有限集合、`ZZ[x]`、`QQ`、$\Lambda$（素因数分解の指数ベクトルを辞書で表す）の
  厳密計算。浮動小数点を使わない。

## 何を確かめるか

二つの主張の証明の各段を一段ずつ確かめる。

### 分配多項式の値の双対分解（`claim_partition_value_dual_factorization`）

$q\in\mathbb{Q}_{(0,1)}$ について
$2^{L^2}\cdot Z_L(q)=(1+q)^{2L^2}\cdot\sum_{(a,b)}G^{a,b}_L(\mathrm{KW}(q))$。

- 1 行目: $Z_L(q)=2\cdot G^{0,0}_L(q)$（低温展開の自明セクター表示の代入）
- 2 行目: 積の結合則による括り直し
- 3 行目: 冪の指数法則 $2^{L^2}\cdot2=2^{L^2+1}$
- 4 行目: 四つの $H^{a,b}_L(q)$ を独立に数え上げ、混合双対恒等式の代入と一致すること
- 5 行目: セクター値双対 $H^{a,b}_L(q)=(1+q)^{2L^2}G^{a,b}_L(\mathrm{KW}(q))$ の四つの適用
- 6 行目: 分配則による $(1+q)^{2L^2}$ の括り出し

$Z_L$ は配位の数え上げ（`partition_polynomial`）、$G^{a,b}_L$・$H^{a,b}_L$ は
偶部分グラフの数え上げで、互いに独立に構成して突き合わせる。

### 双対な点どうしの自由エントロピーの関係（`claim_free_entropy_dual_relation`）

$\Lambda$ の中の等式
$L^2\ell_2+\Phi_L(q)=2L^2\log(1+q)+\log\bigl(\sum_{(a,b)}G^{a,b}_L(\mathrm{KW}(q))\bigr)$。

- 準備の正値性: $0<1+q$、$0<(1+q)^{2L^2}$、$0<2^{L^2}$、$0<Z_L(q)$、$0<S$
- $\log$ は素因数分解の指数ベクトル（辞書 素数 → `ZZ`）として実装し、
  $\Lambda$ の加法・整数倍を素数ごとの `ZZ` の演算で行う
- $\log2=\ell_2$（$2$ は素数）、$L^2\log2=\log(2^{L^2})$、対数の加法性、
  値の双対分解の適用、再び加法性と冪の法則、の六段を一段ずつ検査する

検査点は $q\in\{1/2,\ 1/3,\ 2/5,\ 3/7,\ 9/10,\ 1/40\}\subset\mathbb{Q}_{(0,1)}$ である。
`QQ` の等号・順序比較と素因数分解は厳密であり、数値近似を経由しない。

## 実行方法

```sh
sage check.sage
```
