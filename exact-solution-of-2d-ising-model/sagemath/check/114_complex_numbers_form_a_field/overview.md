# SageMath Check: 114_complex_numbers_form_a_field

## 対象

**対象ラベル**: `complex_numbers_form_a_field` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`

- 範囲: 体の公理（和・積の可換律・結合律・分配律・単位元・逆元）と <multiplicative_group_of_cc>

<definition_of_cc> の和 (a,b)+(c,d)=(a+c,b+d) と積 (a,b)(c,d)=(ac−bd,ad+bc) を成分から組み直し、公理を多数のサンプルで確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_field_axioms.sage` | 体の公理一式と乗法逆元 | 4390 | 2.238e-16 | **PASS** |
| 02 | `check_02_negation_rows.sage` | 証明の加法逆元と `(-1_C)·z` の一致の鎖を一行ずつ。`0·b`・`0·a` を消す行は `real_zero_times_is_zero`（`x → b, a`）、続く 3 行は `real_minus_zero_is_self`（`a → (−1)a`）・`0` は ℝ の加法の単位元（`set_and_algebra_notation`。`x + 0 = x` の `x → (−1)b`）・`real_minus_one_times_is_negation`（`a → a, b`）。`QQ[a, b]` の多項式の等号で比べ、終点が `(a,b)` の加法逆元であることも確かめる | 鎖 1 本 | 厳密（`QQ`） | **PASS** |
| 03 | `check_unit_rows_cite_set_and_algebra_notation.sage` | 加法の単位元の鎖の `(a + 0, b + 0) = (a, b)`（`x + 0 = x` の `x → a, x → b`）と `(−1_C)·z` の鎖の `((−1)a, (−1)b + 0) = ((−1)a, (−1)b)`（`x → (−1)b`）を、行に書いた形と代入どおりに（`set_and_algebra_notation`）。対照（`a + 1 ≠ a`）。`QQ[a, b]` の多項式の等号で比べる | 2 行 | 厳密（`QQ`） | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

<multiplicative_group_of_cc>（C^× が群）の内容はこの check の乗法逆元の部分に含まれる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 114
```

実行ログは `sagemath/check/114_complex_numbers_form_a_field/logs/` に保存してある（この表の数値はそのログから取った）。
