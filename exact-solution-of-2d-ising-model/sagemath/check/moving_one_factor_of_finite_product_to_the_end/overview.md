# SageMath Check: moving_one_factor_of_finite_product_to_the_end

## 対象

**対象ラベル**: `moving_one_factor_of_finite_product_to_the_end` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_moving_one_factor_of_finite_product_to_the_end`（有限積の一つの因子を末尾へ寄せる）
- 範囲: 主張と、帰納法の四つの鎖。有限積は `def_finite_product_of_matrices` どおり左から掛け、一つの添字を除いた有限積は
  `def_finite_product_of_matrices_omitting_one_index` どおり `s_{r,ν}` で添字を並べて組む

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 2` の `ν = 1` の六行と `ν = 2` の五行、`r → r+1` の `ν = r+1` の三行と `ν ≤ r` の十行 | `check_induction_lines.sage` | 前提を満たす族（`A_ν` は不定元の行列 `G`、`ν < j` の `A_j` は `G` の多項式で係数も不定元、`j < ν` の `A_j` は `G` と可換でない独立な不定元の行列）で、各行の項が隣どうし一致することを確かめる（`j < ν` の組の可換性を使わないことの確認。`ν < j` の因子どうしは `G` の多項式で互いに可換なので、それらの組の可換性を使わないことはこの検算では確かめていない）。`s_{r+1,ν}(j) = s_{r,ν}(j)`（`j ≤ r−1`）と `s_{r+1,ν}(r) = r+1`（`ν ≤ r`）も確かめる。独立な経路として Sage の積でも比べる。対照として、`ν < j` の組が可換でなければ主張が外れること | **PASS** | `n = 1, 2, 3` × `r = 2, 3, 4` × 全ての `ν` で 201 行 |

## 計算の帰属と範囲

`QQ` 上の多項式環で厳密に確かめた。浮動小数点はない。一般の `n`・`r` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh moving_one_factor_of_finite_product_to_the_end
```

実行ログは `sagemath/check/moving_one_factor_of_finite_product_to_the_end/logs/` に保存する（2026-11-02）。
