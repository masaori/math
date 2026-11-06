# SageMath Check: real_inclusion_preserves_finite_product

## 対象

**対象ラベル**: `real_inclusion_preserves_finite_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_inclusion_preserves_finite_product`（実数の有限積の包含は包含の有限積に等しい）
- 範囲: 主張 `Π_{j=1}^{m} (r_j)_ℂ = (Π_{j=1}^{m} r_j)_ℂ` と、証明の帰納法の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `m = 1` の 2 行（`def_finite_product_of_complex_numbers`、`def_finite_product_of_real_numbers` を右辺から左辺へ） | `check_induction_chain.sage` | 左から掛けた ℂ の積 `Π_{j=1}^{1}(r_j)_ℂ`、`(r_1)_ℂ`、`(Π_{j=1}^{1} r_j)_ℂ` の 3 つの式が等しい | **PASS** | 厳密 |
| `m → m+1` の 4 行（`def_finite_product_of_complex_numbers`、帰納法の仮定、`real_inclusion_preserves_product`、`def_finite_product_of_real_numbers` を右辺から左辺へ） | 同上 | `m = 1,…,8` で 5 つの式が隣どうし等しいこと、帰納法の仮定の等号が成り立つこと | **PASS** | 厳密（5 通りの列で `m → m+1` の等号 160 個。`m = 1` の 10 個と合わせて 170 個） |
| 主張そのもの | 同上 | Sage の `prod`（独立な経路）と比べる。否定コントロールとして、包含を `(r, 0)` でなく `(r, 1)` にした写像では `m = 2` で両辺が一致しないことを確かめる | **PASS** | 否定コントロール 5 件 |

## 計算の帰属と範囲

ℝ の元は AA、ℂ の元は QQbar で持つ（`r_ℂ := (r, 0)` は `QQbar(r)`。実部 `r`・虚部 `0` であることも確かめる）。
`r_j` の列は 5 通り取った（1 より小さい正の有理数、符号が交互の整数、`def_sector_rayleigh_sup` の `a_+` の成分 `1/√2` の定数列、
無理数を含む実代数的数、`0` を因子に含む列）。浮動小数点と `RR` / `CC` への脱出はない。一般の実数と一般の `m` は人手証明の帰納法が担う。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 各行の式は人手の行の式をそのまま組むので、隣どうしの等号は QQbar の積の結合と包含の定義から構成上ほぼ一致する。
  中身は、独立な経路（Sage の `prod`）との比較と、包含を取り替えた否定コントロールにある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_inclusion_preserves_finite_product
```

実行ログは `sagemath/check/real_inclusion_preserves_finite_product/logs/` に保存する（2026-11-06）。
