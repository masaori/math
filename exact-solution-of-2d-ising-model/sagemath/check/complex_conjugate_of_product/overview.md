# SageMath Check: complex_conjugate_of_product

## 対象

**対象ラベル**: `complex_conjugate_of_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/005_exp_conjugation_proof.ts`
- ブロック: `exp_conjugation_claim_complex_conjugate_of_product`（複素共役は積を保つ）
- 範囲: 鎖の全 8 行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `conj(zw) = conj((xu−yv, xv+yu))`（`definition_of_cc` の積） | `check_product_chain.sage` | `x, y, u, v` を `QQ` 上の不定元に置き、各行を書かれた式どおりに対で組んで隣り合う行を比べる。積の定義を開いた形が `cc_mul` と一致することも確かめた | **PASS** | 厳密等号 |
| `= (xu−yv, −(xv+yu))`（`def_complex_conjugate`） | 同上 | 同上 | **PASS** | 同上 |
| `= (xu−(−y)(−v), −(xv+yu))`（ℝ） | 同上 | 同上 | **PASS** | 同上 |
| `= (xu−(−y)(−v), (−(xv))+(−(yu)))`（ℝ で `−(xv+yu) = (−(xv))+(−(yu))`） | 同上 | 同上 | **PASS** | 同上 |
| `= (xu−(−y)(−v), x(−v)+(−(yu)))`（ℝ で `−(xv) = x(−v)`） | 同上 | 同上 | **PASS** | 同上 |
| `= (xu−(−y)(−v), x(−v)+(−y)u)`（ℝ で `−(yu) = (−y)u`） | 同上 | 同上 | **PASS** | 同上 |
| `= (x,−y)(u,−v)`（`definition_of_cc` の積） | 同上 | 同上 | **PASS** | 同上 |
| `= conj z conj w`（`def_complex_conjugate`）と主張 | 同上 | 両端を `QQ(i)` 係数の `x+iy` へ送った Sage の係数の共役と比べ、具体の `QQ(i)` の 20 組で Sage の `conjugate` と比べた | **PASS** | 同上 |

## 計算の帰属と範囲

浮動小数点はない。ℂ は本文どおり実数の対で持つ（`_shared/complex_as_real_pairs.sage`）。不定元は `QQ` 上の多項式環のもの。

## 確かめられない行と理由

- 定義を開く行は、検算での組み方そのものが定義なので同語反復である。独立な確認は Sage の共役との比較が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_conjugate_of_product
```
