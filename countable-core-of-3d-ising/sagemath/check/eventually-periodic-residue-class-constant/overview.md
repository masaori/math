# SageMath Check: 末尾周期性から剰余類ごとの末尾定数性

## 対象

**対象ラベル**: `claim_eventually_periodic_residue_class_constant`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_eventually_periodic_residue_class_constant`）
- 範囲: 帰納法の基底、後続添字の変形、末尾周期性の反復適用
- 併せて検証: `def_eventually_periodic_finite_box_sequence`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_base_case.sage` | 帰納法の基底が等号の反射律で閉じること | PASS | `QQ` 上で全検査通過 |
| `check_successor_index.sage` | 後続添字の変形と閾値条件 | PASS | `ZZ` 上で全検査通過 |
| `check_periodic_iteration.sage` | 周期ごとの等号を反復すると各剰余類の部分列が定数になること | PASS | 複数の閾値・周期・剰余・反復回数で全検査通過 |

## 備考

- `ZZ` と `QQ` の厳密計算だけを使い、浮動小数点および非可算への脱出は使っていない。

## 実行方法

```bash
for f in sagemath/check/eventually-periodic-residue-class-constant/check_*.sage; do sage "$f"; done
```
