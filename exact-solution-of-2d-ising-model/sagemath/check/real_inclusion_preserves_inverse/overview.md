# SageMath Check: real_inclusion_preserves_inverse

## 対象

**対象ラベル**: `real_inclusion_preserves_inverse` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calc_formulae_claim_real_inclusion_preserves_inverse`（`r ≠ 0` なら (r^{-1})_ℂ = (r_ℂ)^{-1}）
- 範囲: 準備の `r_ℂ ∈ ℂ^×` と、証明の七つの等号（八つの項）の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `r_ℂ ∈ ℂ^×`、鎖の七つの等号（単位元、逆元、結合律、`real_inclusion_preserves_product`、ℝ の r^{-1}r = 1、1_ℂ の略記、単位元） | `check_chain.sage` | ℂ を `QQ` の対として持ち、各項を `definition_of_cc` の積で別々に作って隣り合う項を比べる。(r_ℂ)^{-1} は `definition_of_cc` の積の式で作った r_ℂ w = 1_ℂ を解いて作る（逆元の値を先に置かない）。r は 2, −3, 1/7, −5/4, 11/3, 1, −1 の 7 つ。対照として (r^{-1})_ℂ (−r)_ℂ ≠ 1_ℂ、r = 0 なら r_ℂ = 0_ℂ | **PASS** | 等号 49 個、否定コントロール 8 件 |

## 計算の帰属と範囲

成分はすべて `QQ` で、浮動小数点はない。主張は一般の実数 `r ≠ 0` についてで、ここで確かめたのは有理数の 7 つの値である（各行は体の演算だけを使うので、有理数で行の形の誤りを検出できる）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_inclusion_preserves_inverse
```

実行ログは `logs/` に保存してある。
