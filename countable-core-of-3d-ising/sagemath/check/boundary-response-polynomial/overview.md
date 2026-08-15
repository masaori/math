# SageMath Check: 境界応答多項式

## 対象

**対象ラベル**: `def_boundary_response_polynomial`

- 併せて検証: `claim_boundary_response_specialization_homomorphism`
- 自由境界の $L'=1,L=2$ について、本文の有限和・有限代入・環準同型・境界応答多項式を一段ずつ検証する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_multivariate_finite_sum.sage` | 多変数分配多項式の有限和と全配位数 | PASS | $8$ 点・$12$ 辺・$2^8$ 配位で一致 |
| `check_finite_specialization.sage` | 内箱に接する辺変数を保ち、他を 1 に置く代入 | PASS | 保持する $3$ 変数と置換する $9$ 変数を全て確認 |
| `check_homomorphism_laws.sage` | 加法・乗法・単位元の保存 | PASS | `ZZ` 上の多項式で全て保存 |
| `check_boundary_response.sage` | 代入像と境界応答多項式の直接の有限和の一致 | PASS | $2^8$ 配位の直接和と一致 |

## 備考

すべて有限集合、`ZZ`、有限変数の整係数多項式環による厳密計算であり、浮動小数点と非可算への脱出は使わない。

**2026-08-15 実行: 全四ファイル PASS。**

## 実行方法

```sh
for file in sagemath/check/boundary-response-polynomial/check_*.sage; do sage "$file"; done
```
