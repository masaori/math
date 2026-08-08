# SageMath Check: 転送行列の定義と、配位の重みが行に沿った成分の積であること

## 対象

**対象ラベル**: `claim_rows_bijection`, `claim_transfer_weight_product`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「転送行列」の主張
  「配位全体と行配位の族全体は 1 対 1 に対応する」
  「配位の重みは、行に沿った転送行列の成分の積である」
- 併せて使う定義: `def_lattice` / `def_configuration` / `def_broken_bond_count` /
  `def_row_configuration` / `def_row_restriction` /
  `def_intra_row_broken_count` / `def_inter_row_broken_count` /
  `def_row_family` / `def_rows_map` / `def_matrix_over_row_configs` / `def_transfer_matrix`

### 何を確定させるための検証か

1. 行配位の族の個数が $(2^L)^L=2^{L^2}$ であること（`def_row_family`）。
2. 配位を行の並びとして読む写像 $\mathrm{rows}$ が全単射で、逆写像が $\mathrm{conf}$ であること。
   本文の Step 1・Step 2 に対応する 2 つの等式 $\mathrm{conf}(\mathrm{rows}(\sigma))=\sigma$ と
   $\mathrm{rows}(\mathrm{conf}(c))=c$ を、すべての配位・すべての族について確かめる。
   あわせて像が重複なく $C_L$ を尽くすことも見る。
3. すべての配位について
   $\prod_i T_{\rho_i(\sigma),\rho_{i+1}(\sigma)}=x^{b(\sigma)}$ を確かめる。
   左辺は転送行列の成分（行内・行間の破れの本数から作る）を掛けたもの、右辺は辺の番号を
   $1$ から $2L^2$ まで全部走って数えた破れボンド数から作ったものであり、両者の作り方は独立である。
4. 行列の積・冪・トレースが定義どおりであること（$A^1=A$、$A^{k+1}=A^kA$、対角成分の和）。
   次の節で $\operatorname{Tr}(T^L)$ を扱うための足場である。

$L=1,2,3$ で総当たりする（配位の個数は $2$, $16$, $512$、行配位の族の個数も同じ）。

### 計算の厳密性

すべて `ZZ` と `ZZ[x]` の厳密計算で行う。**浮動小数点は使わない。**
本文がこの章で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない。
転送行列の成分は $x$ の冪であり、$x=e^{-2\beta J}$ の代入は行わない。

## 実行

```sh
sage sagemath/check/transfer-matrix-trace-formula/check.sage
```

## 実行ステータスと結果

| 項目 | 状態 |
| --- | --- |
| 実行 | 2026-08-08 実行（SageMath, `/usr/local/bin/sage`） |
| 結果 | 全アサーション成立（$L=1,2,3$。全配位・全族を総当たり） |

出力:

```text
L = 1: 行配位の族の個数 2^1・rows の全単射性・重みの積・行列演算 をすべて確認
L = 2: 行配位の族の個数 2^4・rows の全単射性・重みの積・行列演算 をすべて確認
L = 3: 行配位の族の個数 2^9・rows の全単射性・重みの積・行列演算 をすべて確認
すべてのアサーションが成立した（L = 1, 2, 3。厳密計算のみ）
```

$L=1$ は縮退した場合であり、行配位は 2 つ、破れは起こらないので転送行列の成分はすべて $1$ になる。
本文の主張はこの場合も含めて成り立つ。

### 表現についての注意

本文は $R_L$ の元そのものを行列の添字に使うが、検証側では Sage の辞書の鍵にするために
行配位を「列番号の順に値を並べたタプル」で表している（`row_config_key`）。
これは本文の $2^L$ 個の元への番号付けにあたり、主張の内容には影響しない
（本文が番号を付けずに書いているのは、番号の付け方に依存しないことを見やすくするためである）。
