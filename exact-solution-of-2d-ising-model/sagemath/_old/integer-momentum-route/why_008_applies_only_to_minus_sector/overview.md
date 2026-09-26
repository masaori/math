# SageMath Check: why_008_applies_only_to_minus_sector（退避）

## 対象

退避対象ラベル: `why_008_applies_only_to_minus_sector`

**このブロックはもう本文ではない。** 整数運動量の経路を本文から外したとき、
`structured-latex/content/013_even_sector_modes.ts` の主張ブロック `evensector_001_claim_why_minus_only`
は参照用ノート `structured-latex/notes/integer_momentum_route_not_adopted.ts` の
`note_evensector_004_claim_commutator_H_check_Z_Y_integer_route_evensector_001_claim_why_minus_only`
（`targets: commutator_of_H_and_check_Z_Y`）へ退避された。ここにある検証は、そのノートに
「本文にあったときの内容のまま」残っている主張と Step 1 を確かめるものである。

ラベルは本文に実在しないので、`tools/verify-check-linkage.ts`（`check/` 配下だけを見る）の対象外である。
本文側の Step 1（`[H_2, Z_j] = -2Y_j` を含むサイトごとの交換関係）は
`commutator_of_H_and_check_Z_Y` の証明へ移り、`check/051_stepwise_identities_of_chapter_Cprime/`
の check_01 が一行ずつ検証している。

## チェック一覧

| ファイル | 検証内容 | 由来 | ステータス | 結果 |
|---|---|---|---|---|
| `check_01_why_minus_only.sage` | 主張: `[H_2, hatZ^{(−)}_μ] = −2 hatY_μ`、`[H_2, hatZ^{(+)}_μ] = −2 hatY_μ + 4e^{−iθ_μ}Y_1`、`hatZ^{(+)} = hatZ^{(−)} − 2e^{−iθ}Z_1`、(+) 側が `−2 hatY` と一致しないこと（全 μ の最小残差 4.0） | もと `check/046_claim_even_sector_modes/` の check_01 | PASS | M=2..5 で残差 ≤ 6.5e-16 |
| `check_02_step1_stepwise.sage` | 証明 Step 1 の各段（`m ≠ j` の 5 段、`[Z_jY_j, Z_j]` の 6 段、まとめ `[H_2, Z_j] = −2Y_j`） | もと `check/051_stepwise_identities_of_chapter_Cprime/` の check_01 の `why_008` の段 | PASS | 12 種類の段、残差すべて 0 |

判定閾値は `TOL = 1e-8`（移動元の 046・051 と同じ）。`check_01` の「一致しない」判定は
`MISMATCH_FLOOR = 1e-3` 以上の残差で行う。行列の成分は 0, ±1, ±i だけなので残差は丸めの範囲に収まる。

## 実行方法

`_prelude.sage` は `../../../_shared/spin_ops.sage` を読む。このディレクトリで実行する。

```bash
cd exact-solution-of-2d-ising-model/sagemath/_old/integer-momentum-route/why_008_applies_only_to_minus_sector
sage check_01_why_minus_only.sage
sage check_02_step1_stepwise.sage
```

SageMath 10.9 の `sage <file>.sage` はスクリプトの `__file__` をパッケージ側の値にするため、
`load(os.path.join(_dir, ...))` が失敗する。その場合は `<file>.sage.py` を生成して
`python <file>.sage.py`（SageMath 環境の python）で実行する。`logs/` のログはこの方法で
2026-09-26 に SageMath 10.9 / Linux で取った。

`run-log.txt` は移動元 046 の `run-log.txt` にあった check_01 の節（2026-09-22、SageMath 10.6 / macOS）を
そのまま移したもの。残差の末尾桁が `logs/` と違うのは環境の差で、判定は同じである。
