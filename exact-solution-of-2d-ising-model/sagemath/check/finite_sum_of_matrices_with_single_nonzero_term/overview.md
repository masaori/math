# SageMath Check: finite_sum_of_matrices_with_single_nonzero_term

## 対象

**対象ラベル**: `finite_sum_of_matrices_with_single_nonzero_term`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_finite_sum_of_matrices_with_single_nonzero_term`（一つを除く項が零行列である行列の有限和は、その一つの項に等しい）
- 範囲: 証明の前置き `(X_a)_{ik} = O_{ik} = 0_C`（a ≠ q）、成分の 2 等号の鎖と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `(X_a)_{ik} = 0_C`（a ≠ q）、`(Σ_a X_a)_{ik} = Σ_a (X_a)_{ik} = (X_q)_{ik}` と主張 | `check_entry_chain.sage` | X_q の成分を `QQ` 上の多項式環の不定元、他の項を零行列に置き、(m, n) ∈ {1,2,3}^2、r = 1..5、全ての q と成分で各行を本文の成分の式で組んで隣と比べる。主張を Sage の行列演算とも比べる。対照: q 以外の項を一つ零でない行列にすると和は X_q にならない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: すべて `QQ` 上の多項式環。浮動小数点は使わない。
- **作り方で自明な比較**: 第 1 等号（`finite_sum_of_matrices_entrywise`）は両辺を同じ成分の式から作る。中身を持つのは第 2 等号（零の項を足しても変わらないこと）である。
- 範囲外: r ≥ 6、m または n ≥ 4。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_matrices_with_single_nonzero_term
```

実行ログは `logs/` に保存する。
