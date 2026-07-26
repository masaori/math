# SageMath Check: 114_complex_numbers_form_a_field

## 対象

**対象ラベル**: `complex_numbers_form_a_field` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.mjs`

- 範囲: 体の公理（和・積の可換律・結合律・分配律・単位元・逆元）と <multiplicative_group_of_cc>

<definition_of_cc> の和 (a,b)+(c,d)=(a+c,b+d) と積 (a,b)(c,d)=(ac−bd,ad+bc) を成分から組み直し、公理を多数のサンプルで確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_field_axioms.sage` | 体の公理一式と乗法逆元 | 4390 | 2.238e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

<multiplicative_group_of_cc>（C^× が群）の内容はこの check の乗法逆元の部分に含まれる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 114
```

実行ログは `sagemath/check/114_complex_numbers_form_a_field/logs/` に保存してある（この表の数値はそのログから取った）。
