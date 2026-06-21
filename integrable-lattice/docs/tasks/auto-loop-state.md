# 自動ループ 状態

daily cron が読み書きする状態ファイル。手順は `auto-loop-runbook.md`。

```yaml
current_cycle: 0
last_run: 2026-06-21     # 最後に daily 実行した日付（YYYY-MM-DD）
cron_armed: 2026-06-21   # cron を作成/再武装した日付（session-only, 7日で失効）
```

## cycle 0 step 列

slice は `inputs/seeds/canonical-papers.md` 準拠。slice 1（six_vertex_dwbc_determinant）は既に harvest/gap_map/generate 済み（`outputs/maps/001_...`, `outputs/candidates/000_...`）なので step 列から除外。

| # | step | status | done日 | 観察メモ |
|---|------|--------|--------|----------|
| 1 | harvest:rsos_character_identity | done | 2026-06-21 | corpus 002 + query 002 作成。13 record / 6 coverage axis（unitary_minimal_finitized, nonunitary_forrester_baxter, bailey_construction, branching_coset, rank_affine_generalization, representation_root_of_unity）。多数 attribution は `verify` 留め（cycle 0 は固めない）。unknown 候補源: 境界/欠陥付き RSOS の finitized character、高ランク(A_{n-1}^{(1)}, n>2)の boson=fermion 多項式恒等式。 |
| 2 | gap_map:rsos_character_identity | done | 2026-06-21 | `outputs/maps/002_...` 作成。known 4（単位/非単位 minimal finitized char, su(2) coset 分岐, A_n config-sum=character）/ needs_review 2（Bailey 経路重複, root-of-unity Hecke）/ unknown 3（U1 境界付き RSOS finitized char【最有力】, U2 高ランク finitized 恒等式, U3 su(2)外 coset finitization）。harvest 補強候補(Behrend-Pearce 境界 RSOS, Kirillov-Reshetikhin 高ランク fermionic form)は観察に留め cycle 0 では未実施。 |
| 3 | generate:rsos_character_identity | done | 2026-06-21 | `outputs/candidates/001_...` に U1/U2/U3 を粗く起こした（境界つき RSOS finitized char [medium]、高ランク A_n finitized 恒等式 [medium, novelty_risk 高]、su(2)外 coset finitization [low]）。全て unchecked。slice 2 完了。 |
| 4 | harvest:tl_loop_finitized_character | done | 2026-06-21 | corpus/query 003 作成。11 record / 6 coverage axis（strip_finitized_character, boundary_sector_character, boundary_tl_algebra, loop_correlation_combinatorics, tl_relation_anchor, loop_critical_context）。Pearce 系 LM(p,p') finitized Kac character + blob/2-boundary TL link-state。多数 attribution は verify 留め。 |
| 5 | gap_map:tl_loop_finitized_character | done | 2026-06-21 | `outputs/maps/003_...`。known 4（LM(p,p') strip finitized char, dense polymers defect char, blob/2BTL link-state, dense loop 共形境界分類）/ needs_review 2（Robin・NS-R 超共形, 2点境界 loop 相関）/ unknown 3（U1 一般2境界パラメータ finitized char【最有力】, U2 fused-TL finitized char, U3 loop 境界相関の有限公式）。**横断観察**: slice 1/2/3 すべてで「境界軸 × 有限公式」が共通 unknown 筋 → vertex-face/loop 対応で束ねられる可能性、cycle 1 方向候補。 |
| 6 | generate:tl_loop_finitized_character | todo | | |
| 7 | harvest:dimer_pfaffian_boundary | todo | | |
| 8 | gap_map:dimer_pfaffian_boundary | todo | | |
| 9 | generate:dimer_pfaffian_boundary | todo | | |
| 10 | rank:cycle0 | todo | | 4 slice 出揃ってから。cycle 0 成功条件。 |
| 11 | decide:cycle1 | todo | | 観察に基づき cycle 1 step 列をこのファイルへ書き起こす。 |

## 逸脱ログ

MVP コンセプトマッチ点検で不合格になり是正した内容を、step 番号・日付付きで記録する。

（なし）
