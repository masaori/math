# SageMath 検算: 有限舞台上のブロック（分割）型更新

## 対象

**対象ラベル**: `claim_block_phase_characterization`

- 併せて検証するラベル: `def_block_partition`、`claim_block_partition_blocks_are_membership_fibers`、
  `def_block_local_rule_family`、`def_block_phase_update`、`claim_block_phase_membership_finite_decidable`、
  `claim_synchronous_rule_not_forced_block_local`。
- 分割条件と所属ブロックの繊維、一相更新の特徴づけの両方向、有限所属判定、同期二セル交換との境界を、
  本文の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_partition_membership_fibers.sage` | 非空部分集合族の全候補から分割条件を走査し、各ブロックが所属ブロック写像の繊維に一致することを検査する | PASS | セル数四以下の候補 32,907 件から全分割 24 件を抽出し、全 51 ブロックで一致 |
| `check_phase_characterization_forward.sage` | 全ブロック局所規則族から作る一相更新が、同じブロック入力を持つ配位対のブロック出力を一致させる三等号を検査する | PASS | セル数二以下の全 277 規則族・入力対比較 4,624 件で成立 |
| `check_phase_characterization_reverse.sage` | ブロック内入力だけへの依存を満たす全写像から零延長で局所規則族を復元し、元の写像を再構成する | PASS | 全 517 写像・分割対のうち条件を満たす 277 対を、局所入力 1,096 件から再構成 |
| `check_membership_finite_decision.sage` | 全入力対を走査する判定と、全ブロック局所規則族を列挙する独立な存在判定を比較する | PASS | 全 517 写像・分割対で一致（受理 277、拒否 240） |
| `check_synchronous_boundary.sage` | 二セル交換が同期局所更新でありながら、一元ブロック分割への依存条件を破る明示入力対を検査する | PASS | 全四入力で交換写像を確認し、入力 `(0,0)` と `(0,1)` で依存条件の破れを確認 |

## 範囲と限界

- 分割条件はセル数四以下で、非空部分集合からなる有限集合の全候補 32,907 件を走査し、全ブロック分割
  24 件を尽くす。各ブロックと所属ブロック写像の対応する繊維を全件比較する。
- 一相更新の特徴づけと有限所属判定はセル数二以下で、全ブロック分割、全大域写像、全ブロック局所規則族を
  尽くす。これは明示した有限範囲のプログラミングによる検証であり、一般の有限舞台についての証明ではない。
  一般証明は構造化記述にある。
- 状態集合は二元集合としてだけ使う。有限集合と有限写像表だけで閉じ、状態同士の加法、対数、除算、
  浮動小数点、全配位の逆極限、極限、実数体・複素数体は使わない。

## 実行方法

```bash
for file in sagemath/check/block-partition-rule-class/check_*.sage; do sage "$file"; done
```
