# 自動ループ Runbook（daily, Λ-statement 版）

このファイルは daily cron が **毎回まっさらな文脈で** 読み、決定論的に1日分を実行するための手順書。
状態は `auto-loop-state.md` に永続化する。判断の根拠はこの2ファイル + リポジトリ内一次情報（特に `inputs/seeds/lambda-statement-program.md` と `docs/discussion/対数順序群上の統計力学/`）のみ。

## 大方針（最重要・絶対遵守）

集める statement は **「Λ/ℚ̄ で決定可能・ℝ脱出隔離・形式検証可能」**（再定義）。整理軸は **決定可能性の梯子（ℕ⊂ℚ⊂Λ⊂ℚ̄ ⊂ ℝ）＋四軸（帰属／計算可能性／複雑性／可解性）**。文献の「厳密可解」分類（determinant か character か）で整理してはならない。
cycle 0 は探索方向 **A–F を絞らず広く浅く** 1周回す。各 step 完了ごとに点検 → main 差分 push → 次 step。

## 1日の実行手順

1. **同期**: 作業ツリーで `git fetch origin main && git reset --hard origin/main`。
2. `auto-loop-state.md` を読み、`status: todo` の最初の step を特定する。無ければ「サイクル完了処理」へ。
3. その step を **1つだけ** 実行する（下の「step 種別」）。`inputs/seeds/lambda-statement-program.md` の梯子・四軸・台帳・選別基準を使う。
4. **点検チェックリスト**（下）。不合格なら是正、逸脱を `auto-loop-state.md` の「逸脱ログ」へ記録してから合格させる。
5. `auto-loop-state.md` を更新（step を `done`、観察メモ・日付）。必要なら `MEMORY.md` も更新。
6. **main へ push**（下の git レシピ）。push 後 `git rev-parse origin/main` でマージを確認。
7. **次 step があれば 3 に戻る。todo が尽きるまで連続消化する**（リポジトリ CLAUDE.md「自律実行：判断を要さない限り止まらない」）。1発火1 step で止めない。判断が必要な場合（CLAUDE.md の条件）だけ止めて問う。todo が尽きたら「サイクル完了処理」。

> step ごとに必ず 4→5→6 を回す（まとめ push 禁止）。ただし step 完了を理由に停止しない＝点検・push を各 step で行いつつ次 step へ連続して進む。

### main マージ結果の報告（厳守・ユーザー指示）

各 step の完了報告で **main にマージしたか否かを必ず明示**: 成否／成功時は `<before>..<after>` commit ハッシュ／失敗・未push時は理由。`origin/main` が前進した事実をもって「マージ済み」と報告する。

## 点検チェックリスト（push 前に毎回）

すべて満たすこと。1つでも×なら是正。

- [ ] **帰属を明示**: 各候補で対象量の home（ℤ[x] / Λ / ℚ̄ / ℝ脱出箇所）を書いた。
- [ ] **選別基準 (i)–(iv)**: Λ/ℚ̄ で決定可能・ℝ脱出隔離（一点 or ℝ不使用）・形式検証可能・単一軸のずれ（`lambda-statement-program.md`）。
- [ ] **梯子/四軸で整理**: 文献操作型（determinant / character / Yang-Baxter…）で整理していない。模型は基質として使ってよいが、整理軸は梯子＋四軸。
- [ ] **Schanuel 層・ℝ本体回避**: 対象量の本体が exp/log 積（$\ell_p\ell_q$）や $\mathbb{R}$ に住んでいない。住むなら ℝ脱出として隔離・明示。
- [ ] **広く浅く（cycle 0）**: A–F を絞っていない。深い証明・06_verify・sagemath 厳密検証はこの周ではしない（深さは方向確定後）。

## step 種別（cycle 0 の step 列）

探索方向 A–F（`lambda-statement-program.md`）を1方向ずつ、模型横断で **広く浅く**。

- `explore:<dir>` … `skills/integrable-lattice-harvest` + `gap-map` + `generate` を1方向ぶん薄く回す。出力: `outputs/maps/`（Λ gap-map セル）＋ `outputs/candidates/`（選別基準を満たす粗い候補、`resolved_risk: unchecked`）。必要な一次情報は `docs/discussion/対数順序群上の統計力学/` と最小限の web 検索。
- `rank:cycle0` … `skills/integrable-lattice-rank`。A–F 出揃ってから観察を `outputs/reports/` へ。決定可能性・形式検証可能性・複雑性×可解性で順位付け。これが cycle 0 成功条件（件数でなく、次に深掘りする Λ-statement の筋を根拠付きで選べる状態）。

## サイクル完了処理

`rank:cycle0` まで done になったら cycle 0 完了。観察に基づき cycle 1 の方向（A–F のどれを深掘りするか／どの模型に絞るか）を決め、`auto-loop-state.md` に cycle 1 step 列を書き起こし `current_cycle` を進める。cycle 1 以降で初めて 06_verify・sagemath 厳密検証（SageMath `ZZ/QQ/QQbar`・素因数分解）を確定方向に投下する。

## git レシピ（main へ直接 push）

`main` は branch protection 無し → 直接 fast-forward push。

```bash
git -C <worktree> add -A
git -C <worktree> commit -m "integrable-lattice auto-loop(cycle0): <step>"
git -C <worktree> push origin HEAD:main
```

non-fast-forward で蹴られたら:

```bash
git -C <worktree> fetch origin main && git -C <worktree> rebase origin/main && git -C <worktree> push origin HEAD:main
```

`--delete-branch` や `main` の local checkout は使わない。

## cron 再武装（7日 auto-expire 対策）

recurring cron は7日で失効（session-only）。ループ未完なのに失効間近/失効済みなら同等の daily cron を `CronCreate` で再作成し、`auto-loop-state.md` に再武装日を記録する。
