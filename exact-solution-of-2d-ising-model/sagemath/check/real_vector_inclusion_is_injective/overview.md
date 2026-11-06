# SageMath Check: real_vector_inclusion_is_injective

## 対象

**対象ラベル**: `real_vector_inclusion_is_injective` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_real_vector_inclusion_is_injective`（`ι^n_{ℝ→ℂ}` は単射）
- 範囲: 証明の 3 行の鎖 `(x_i)_ℂ = (ι^n(x))_i = (ι^n(y))_i = (y_i)_ℂ`、`inclusion_rr_to_cc_is_injective` による `x_i = y_i`、結び `x = y`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 3 行の鎖（`def_real_vector_inclusion`、仮定、`def_real_vector_inclusion`）と `x_i = y_i`・`x = y` | `check_proof_lines.sage` | 大きさ `n ∈ {1,2}`、成分を有理数と `√2, √3, √12/2` の 7 個の候補から独立に選んだ組 `(x, y)` を総当たりする。仮定 `ι^n(x) = ι^n(y)` を満たす組で鎖の 4 個の式、`(a,0) = (b,0)` の第 1 成分の比較、`x_i = y_i`、`x = y` を確かめ、満たさない組で `x ≠ y` を確かめる（`√3` と `√12/2` は別の式で書いた同じ実数なので、仮定を満たす組には別の式で作った組が入る） | **PASS** | 仮定を満たす 90 組・満たさない 2360 組で成り立つ |

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の 1→2 行・3→4 行は、`iota` を定義の式そのもので作るので構成上一致する。中身は、独立に作った組で仮定と結論の同値を確かめるところと、`QQbar(r)` が実部 `r`・虚部 `0` の元（`r_ℂ = (r, 0)`）であることの確認にある。

## 計算の帰属と範囲

- **厳密**: ℝ の元は AA、ℂ の元は QQbar で持つ。浮動小数点は使わない。
- 範囲外: 選んだ以外の大きさ・成分。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_vector_inclusion_is_injective
```

実行ログは `logs/` に保存する。
