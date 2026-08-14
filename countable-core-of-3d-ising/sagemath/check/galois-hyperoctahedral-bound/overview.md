# SageMath Check: Galois 群の上限

## 対象

**対象ラベル**: `claim_galois_hyperoctahedral_bound`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `galois_bound_claim_hyperoctahedral`）
- 範囲: 回文性から逆数対を得て、分解体の自己同型の作用が逆数対を保ち忠実であることを示す証明全体
- 併せて検証: `def_partition_polynomial`、`claim_palindrome`、`claim_partition_support_endpoints`、`def_nonfixed_reciprocal_roots`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_palindromic_identity.sage` | 回文性から得る Laurent 多項式の四段の等式 | PASS | `L=1,2` で成立 |
| `check_reciprocal_root_pairs.sage` | 非零根の逆数閉性と、固定根を除いた二元対分割 | PASS | `L=1,2` で成立 |
| `check_galois_pair_action.sage` | 分解体の全自己同型による根の保存、逆数との可換、対の保存 | PASS | `L=2` の全自己同型で成立 |
| `check_faithful_root_action.sage` | 非固定根への作用の忠実性 | PASS | `L=2` で固定部分群は恒等写像のみ |

## 備考

- 箱の一辺を 1 と 2 に固定する。前二件は `ZZ`・Laurent 多項式環・`QQbar`、後二件は一辺 2 の分配多項式の `QQ` 上の分解体で厳密に検証する。
- 重複根は根集合へ一度だけ入れ、根 `-1` は有理な固定根として作用対象から除く。一辺 2 の例は両方を実際に含む。
- 浮動小数点および非可算への脱出は使わない。
- 2026-08-15 に全ファイルを実行し、すべて通過した。

## 実行方法

```sh
for f in sagemath/check/galois-hyperoctahedral-bound/check_*.sage; do sage "$f"; done
```
