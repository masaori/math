# 自動ループ Runbook（daily, Λ-statement 版）

このファイルは daily cron が **毎回まっさらな文脈で** 読み、決定論的に1日分を実行するための手順書。
状態は `auto-loop-state.md` に永続化する。判断の根拠はこの2ファイル + リポジトリ内一次情報（特に `inputs/seeds/lambda-statement-program.md` と `docs/discussion/対数順序群上の統計力学/`）のみ。

## 大方針（最重要・絶対遵守）

集める statement は **「Λ/ℚ̄ で決定可能・ℝ脱出隔離・形式検証可能」**（再定義）。整理軸は **決定可能性の梯子（ℕ⊂ℚ⊂Λ⊂ℚ̄ ⊂ ℝ）＋四軸（帰属／計算可能性／複雑性／可解性）**。文献の「厳密可解」分類（determinant か character か）で整理してはならない。
cycle 0 は探索方向 **A–F を絞らず広く浅く** 1周回す。各 step 完了ごとに点検 → main 差分 push → 次 step。

### 証明の書き方（厳守・ユーザー指示）

**1. できる限り Λ の言葉で証明を記述し、可算の世界と非可算の世界を分別しながら証明する。**

- 証明は**可能な限り対数順序群 Λ（＝素数の対数が張るアルキメデス順序アーベル群）の言葉で書く**。
  Λ 上では順序の判定が整数比較に還元でき、決定可能性が保たれる。
- **可算の世界（ℕ / ℚ / Λ / ℚ̄）と非可算の世界（ℝ / ℂ）を混ぜない。** どの主張がどちらに住んでいるかを
  各ステップで意識し、**非可算側へ移った箇所を必ず明示する**（「ここで ℝ へ脱出する」と書く）。
- ℝ への脱出は**不可欠な箇所（指数評価・N→∞ の連続極限・微分・積分）に限る**。中間体を経ず一気に ℝ へ出す。
  Fisher 零点の ℚ̄ は別建ての可算構造（`ℤ[x]` の分解体）として扱い、ℝ と混同しない。
- 詳細と用語は `docs/discussion/対数順序群上の統計力学/` を一次情報とする（特に 00 記号と定義、
  07 帰属／計算可能性／複雑性／可解性の4分離、09 2D Ising 閉形式の可算的導出の Step 1–4）。

**2. 証明は構造化 LaTeX の形式で残す。既存の証明も順次移行し、移行完了後に Typst を廃止する。**

- **今後の証明は、すべて構造化 LaTeX（`structured-latex/`）の形式で書く。** 新規に Typst で証明を書かない。
- **流儀は `exact-solution-of-2d-ising-model/structured-latex/` を正本として確認すること。**
  - ブロック（`content/*.mjs`）が文書本体。**配列の並びが文書順の正準表現**。
  - 相互参照は**ラベル**で張る（パス非依存）。数値検証との対応もラベル基準。
  - **参照用ノート（`notes/*.mjs`）は文書本体ではない。** 最終成果物は `content/` だけから生成するので、
    ノートは出版物に混入しない。「正しさに必要ならそれは注記ではない」＝必要な事柄は `statement` に書く。
  - スキーマと検証は `schema.mjs` / `tools/validate-content.mjs` を参照・流用する。
- **既存の Typst の証明（`main.typ`, `parts/`）は順次この形式へ移行する。** 移行は step の合間に少しずつ進めてよい。
- **移行が全て終わったら Typst による記述を廃止する**（`_old/typst/` へ退避。削除ではなく温存し、
  退避先に「正本は構造化 LaTeX 側」である旨の README を置く）。
- **移行時の必須確認**: ブロック数や参照解決だけを見て「移行完了」と判断しない。
  **証明の中身が確実に運ばれたか**を原本と突き合わせて確認すること
  （イジング側で、主要定理の証明が移行漏れで100コミット以上失われていた事故がある。
  検出ツール `verify-no-lost-proofs.mjs` を流用してよい）。

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
- [ ] **Λ の言葉で書いた**: 証明・論証を可能な限り Λ の言葉で記述した。可算（ℕ/ℚ/Λ/ℚ̄）と非可算（ℝ/ℂ）を混ぜず、**ℝ へ脱出した箇所を明示**した。
- [ ] **構造化 LaTeX で残した**: この step で証明を書いたなら、Typst ではなく `structured-latex/` の形式で書いた。既存 Typst 分の移行を進めた場合は、**証明の中身が原本から確実に運ばれたことを突き合わせて確認**した。

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
