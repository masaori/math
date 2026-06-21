# 自動ループ Runbook（daily）

このファイルは、daily cron が **毎回まっさらな文脈で** 読み、決定論的に1日分を実行するための手順書。
状態は `auto-loop-state.md` に永続化する。判断の根拠はこの2ファイル + リポジトリ内一次情報のみ。

## 大方針（最重要・絶対遵守）

MVP は固定成果物ではなく **広く薄く集めて観察し方向を絞るサイクル**（`README.md`「MVP の意味（サイクル）」、`docs/architecture.md`「サイクル」）。
このループは cycle 0 を **広く薄く** 1周回すためのもの。**各 step 完了ごとに**「MVP コンセプトとの一致」を点検し、合格してから **main に差分 push** し、次 step へ進む。

## 1日の実行手順

1. **同期**: 作業ツリー（`integrable-lattice` を含む worktree）で `git fetch origin main && git reset --hard origin/main`。作業ツリーがクリーンであることが前提（前日 step は push 済みのはず）。
2. `auto-loop-state.md` を読み、`status: todo` の最初の step を特定する。todo が無ければ「サイクル完了処理」へ。
3. その step を **1つだけ** 実行する（下の「step 種別」参照）。対応する `skills/integrable-lattice-*` の手順に従う。
4. **MVP コンセプトマッチ点検**（下のチェックリスト）。1つでも不合格なら、行き過ぎた深さを削る／巻き戻し、逸脱を `auto-loop-state.md` の「逸脱ログ」に記録してから合格させる。
5. `auto-loop-state.md` を更新（当該 step を `done`、観察メモ・日付を追記）。必要なら `MEMORY.md` も更新。
6. **main へ push**（下の git レシピ）。
7. まだ当日の時間/予算に余裕があり、かつ次 step があれば 3 に戻る。無ければ当日終了し、完了報告を残す。

> step ごとに必ず 4→5→6 を回す。複数 step をまとめて1回 push してはならない（「各 step 完了ごとに push」がユーザー指示）。

## MVP コンセプトマッチ点検チェックリスト（push 前に毎回）

すべて満たすこと。1つでも×なら是正してから push。

- [ ] **薄く広く**: この step で 06_verify を回していない／sagemath 数値検証をしていない／anchor を深掘り固めしていない／厳密な定理形を書いていない（cycle 0 では全て禁止）。
- [ ] **粗くてよい**: 生成候補は `resolved_risk: unchecked` / `novelty_risk: unchecked` のまま、anchor 付きの粗い形。
- [ ] **per-item コスト最小**: 特定の1セル/1候補に不均衡な深さを投下していない。
- [ ] **ループ目的に資する**: この step は4 slice 横断のカバレッジを進め、07_rank で「模型 × 操作型 × 境界」を比較できる状態に近づけている（= cycle 0 成功条件「根拠付きで cycle 1 方向を選べる」に寄与。固定件数を目的にしていない）。
- [ ] **スコープ固定**: `inputs/seeds/canonical-papers.md` の当該 slice の model_family / operation の範囲内。幅/深さ・取捨・投資量を**事前に**決め打ちしていない（それは 07_rank 観察後に決める）。

## step 種別（cycle 0 の step 列）

各 slice につき harvest → gap_map → generate を **浅く**。slice は `inputs/seeds/canonical-papers.md` 準拠。

- `harvest:<slice>` … `skills/integrable-lattice-harvest`。first-pass query log + curated corpus を `inputs/` に薄く作る。
- `gap_map:<slice>` … `skills/integrable-lattice-gap-map`。`outputs/maps/` に既解決/空白セル表。
- `generate:<slice>` … `skills/integrable-lattice-generate`。空白セルから候補を `outputs/candidates/` に粗く（unchecked のまま）。
- `rank:cycle0` … `skills/integrable-lattice-rank`。4 slice 出揃ってから観察を `outputs/reports/` に。これが cycle 0 成功条件。
- `decide:cycle1` … 観察に基づき cycle 1 の方向（操作型 slice 追加 / 家族絞り込み）を `MEMORY.md` と report に。

## サイクル完了処理

`rank:cycle0` と `decide:cycle1` まで done になったら cycle 0 完了。
`decide:cycle1` の結論に基づき、`auto-loop-state.md` に cycle 1 の step 列を新規に書き起こし、`current_cycle` を進める。次の daily 実行はその step 列を回す。これがサイクルの **ループ**。

## git レシピ（main へ直接 push）

`main` は branch protection 無し → 直接 fast-forward push でよい。

```bash
git -C <worktree> add -A
git -C <worktree> commit -m "integrable-lattice auto-loop(cycle0): <step>"
git -C <worktree> push origin HEAD:main
```

push が non-fast-forward で蹴られたら（他 worktree が main を進めた場合）:

```bash
git -C <worktree> fetch origin main && git -C <worktree> rebase origin/main && git -C <worktree> push origin HEAD:main
```

`--delete-branch` や `main` の local checkout は使わない（他 worktree が main を占有しているため失敗する）。

## cron 再武装（7日 auto-expire 対策）

recurring cron は7日で自動失効する。daily 実行時、もしループが未完なのに cron が失効間近/失効済みなら、同等の daily cron を `CronCreate`（durable, recurring）で再作成し、`auto-loop-state.md` に再武装日を記録する。
