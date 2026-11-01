# SageMath Check: complex_conjugate_of_difference

## 対象

**対象ラベル**: `complex_conjugate_of_difference` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/005_exp_conjugation_proof.ts`
- ブロック: `exp_conjugation_claim_complex_conjugate_of_difference`（複素共役は差を保つ）
- 範囲: 準備（`−1_C` の共役）の 4 行、主張の鎖の 7 行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `conj(−1_C) = conj((−1,0)) = (−1,−0) = (−1,0) = −1_C` | `check_difference_chain.sage` | 各行を書かれた式どおりに対で組んで隣り合う行を比べる | **PASS** | 厳密等号 |
| `conj(z−w) = conj(z+(−w))`（`def_complex_difference`） | 同上 | `x, y, u, v` を `QQ` 上の不定元に置き、各行を書かれた式どおりに対で組んで隣り合う行を比べる | **PASS** | 同上 |
| `= conj z + conj(−w)`（`complex_conjugate_of_sum` の `m = 2`） | 同上 | 同上 | **PASS** | 同上 |
| `= conj z + conj((−1_C)w)`（`multiply_by_minus_one`） | 同上 | 同上 | **PASS** | 同上 |
| `= conj z + conj(−1_C) conj w`（`complex_conjugate_of_product`） | 同上 | 同上 | **PASS** | 同上 |
| `= conj z + (−1_C) conj w`（準備） | 同上 | 同上 | **PASS** | 同上 |
| `= conj z + (−conj w)`（`multiply_by_minus_one`） | 同上 | 同上 | **PASS** | 同上 |
| `= conj z − conj w`（`def_complex_difference`）と主張 | 同上 | 両端を `QQ(i)` 係数の `x+iy` へ送った Sage の係数の共役・減法と比べ、具体の `QQ(i)` の 20 組で Sage の `conjugate` と減法と比べた | **PASS** | 同上 |

## 計算の帰属と範囲

浮動小数点はない。ℂ は本文どおり実数の対で持ち、`−w` は `(−1_C)w`、差は `z + (−w)` として組む（`_shared/complex_as_real_pairs.sage`）。

## 確かめられない行と理由

- 定義を開く行は、検算での組み方そのものが定義なので同語反復である。独立な確認は Sage の共役・減法との比較が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_conjugate_of_difference
```
