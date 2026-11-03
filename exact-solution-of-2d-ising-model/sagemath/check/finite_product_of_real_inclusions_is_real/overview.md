# SageMath Check: finite_product_of_real_inclusions_is_real

## 対象

**対象ラベル**: `finite_product_of_real_inclusions_is_real`

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_finite_product_of_real_inclusions_is_real`（実数の包含の有限積は実数の包含）
- 範囲: 主張と、帰納法の二つの鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `m = 1` の 2 行と、`m → m+1` の 4 行 | `check_induction_lines.sage` | ℂ を実数の対（`definition_of_cc` の積）で持ち、`r_j` を不定元に置いて、有限積を左から掛ける経路で各行を作り、帰納法の仮定（`s_ℂ = ∏_{j≤m} z_j`）も確かめる。対照 2 件: `i` が 1 個なら虚部が残り、2 個なら実数に戻る | **PASS** | `m = 1,…,8` |

## 計算の帰属と範囲

- **厳密**: `QQ[r_1, …, r_9]` の多項式の等号で確かめた。不定元の等号なので、任意の実数を代入しても保たれる。浮動小数点はない。
- 一般の `m` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_product_of_real_inclusions_is_real
```

実行ログは `logs/` に保存する。
