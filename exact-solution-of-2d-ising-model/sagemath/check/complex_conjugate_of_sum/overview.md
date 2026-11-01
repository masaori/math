# SageMath Check: complex_conjugate_of_sum

## 対象

**対象ラベル**: `complex_conjugate_of_sum` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/005_exp_conjugation_proof.ts`
- ブロック: `exp_conjugation_claim_complex_conjugate_of_sum`（複素共役は有限和を保つ）
- 範囲: 準備（二つの和）の鎖、帰納法の `m = 1` の鎖と `m → m+1` の鎖、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `conj(z+w) = conj((x+u, y+v))`（`definition_of_cc` の和）から `= conj z + conj w`（`def_complex_conjugate`）までの 5 行 | `check_two_terms_and_induction.sage` | `x, y, u, v` を `QQ` 上の不定元に置き、各行を書かれた式どおりに対で組んで隣り合う行を比べる。左端を `QQ(i)` 係数の `x+iy` へ送った Sage の係数の共役と比べた | **PASS** | 厳密等号 |
| 帰納法 `m = 1` の 2 行（`def_finite_sum_of_complex_numbers`） | 同上 | 同上 | **PASS** | 厳密等号 |
| 帰納法 `m → m+1` の 4 行（`def_finite_sum_of_complex_numbers`・準備・帰納法の仮定・`def_finite_sum_of_complex_numbers`） | 同上 | `z_1,…,z_{m+1}` を不定元の対に置き、帰納法の仮定の行は `m` 項の主張を直接確かめてから使う。左端を Sage の係数の共役と比べた | **PASS** | `m = 1,…,7` で厳密等号 |
| 主張 | 同上 | 具体の `QQ(i)` の点で、両端を Sage の `conjugate` と比べた | **PASS** | `m = 1,…,8` |

## 計算の帰属と範囲

浮動小数点はない。ℂ は本文どおり実数の対で持つ（`_shared/complex_as_real_pairs.sage`）。不定元は `QQ` 上の多項式環のもの。

## 確かめられない行と理由

- 帰納法そのもの（すべての `m` で成り立つこと）は人手証明が担う。検算は `m = 1,…,7` の段を確かめるにとどまる。
- `def_finite_sum_of_complex_numbers` を開く行は、検算での組み方そのものがその定義なので同語反復である。独立な確認は Sage の和と共役との比較が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_conjugate_of_sum
```
