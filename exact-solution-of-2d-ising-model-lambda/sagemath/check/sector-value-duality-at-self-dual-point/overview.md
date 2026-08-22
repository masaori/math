# 自己双対点における高温側と低温側のセクター対応

## 対象

**対象ラベル**: `claim_sector_value_duality_at_algebraic_point`

**対象ラベル**: `claim_self_dual_point_low_high_sector_correspondence`

- ファイル: `structured-latex/content/main-text.ts`
- 範囲: 代数的数上の双対恒等式と、自己双対点への特殊化

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_dual_weight_identity.sage` | 双対変換の一辺の重みの等式 | PASS | 3つの代数的数で厳密一致 |
| `check_sector_factorization.sage` | 有限和のセクター双対恒等式 | PASS | 格子サイズ3種・4セクター・3点で厳密一致 |
| `check_self_dual_fixed_point.sage` | 自己双対点が双対変換の不動点であること | PASS | `QQbar` で厳密一致 |
| `check_self_dual_sector_correspondence.sage` | 自己双対点で高温側と低温側の変数が一致した恒等式 | PASS | 格子サイズ3種・4セクターで厳密一致 |

## 備考

- すべて `ZZ[x]` と `QQbar` の厳密計算であり、浮動小数点、実数体、複素数体への脱出はない。
- 相転移の存在や非解析性は検査対象に含めない。ここで検査するのは有限系の双対恒等式だけである。

## 実行方法

```bash
for f in sagemath/check/sector-value-duality-at-self-dual-point/check_*.sage; do sage "$f"; done
```
