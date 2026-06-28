# T3 Pure 候補: 整数転送行列の周期に対する Wall 型等式

検証: `sagemath/check/cycle3_T3_period/`。文献: Pisano period 理論（π(p^k) | p^{k-1}π(p) は既知, 等号は Wall–Sun–Sun 型未証明予想）。
位置づけ: D-U2（命題 A）の周期 π(p,k) の上界を、純粋数学（数論）の既知枠に接続し、本プロジェクト固有の問いを立てる（トラック3 Pure）。

## 背景（既知, rigorous）

$Z_N=\mathrm{Tr}\,T^N$ は charpoly($T$)$\in\mathbb{Z}[x]$ を特性方程式とする線形漸化列。線形漸化列（Pisano 周期の一般化）について:
$$\pi(p^k)\ \big|\ p^{k-1}\,\pi(p)\qquad(\text{rigorous, 既知}).$$
これが D-U2 命題 A の周期 $\pi(p,k)=$（$T^N\bmod p^k$ の周期）の**厳密上界**を与える:
$$\pi(p,k)\ \big|\ p^{k-1}\pi(p,1),\quad \pi(p,1)\ \big|\ \mathrm{ord}_{GL_d(\mathbb{F}_p)}(\bar T)\ \big|\ \mathrm{lcm}\{p^{e_i}-1\}\ (\le \text{eigenvalue orders}).$$

## 候補命題（Wall 型等式, 本プロジェクト固有）

```yaml
id: T3-integrable-transfer-matrix-wall-equality
title: 整数転送行列の周期に対する Wall 型等式 π(p,k)=p^{k-1}π(p,1)
track: T3-Pure
status: conjecture (検証済・未証明)
statement: >
  可積分模型の整数転送行列 T∈M_d(ℤ) と素数 p に対し、Z_N=Tr T^N の mod p^k 周期 π(p,k) は
  π(p,k) = p^{k-1}·π(p,1)  (k≥1)
  を満たす（Wall 等式）。一般の線形漸化列では π(p^k)=p^{k-1}π(p) は未証明予想
  (Wall–Sun–Sun 型; Fibonacci で Wall 予想として有名)。本候補は「可積分転送行列という構造を持つ場合に等式が常に成り立つか」を問う。
evidence: >
  六頂点 (1,1,2),(1,1,1),(2,1,1) L=2, p=3,5,7 で k=1..3 すべて等式成立(p|det の場合も含む)。
  上界 π(p,k)|p^{k-1}π(p,1) は全例で成立(既知 rigorous)。
why_interesting: >
  (a) D-U2 命題 A の周期に閉じた値を与える(等式が真なら π(p,k) が π(p,1) と p,k から完全決定)。
  (b) Wall–Sun–Sun 型の難問に、可積分構造(固有値が代数的・Newton 多角形)という追加情報を持ち込む新しい切り口。
  (c) 反例があれば「Wall 等式を破る整数行列」の具体例(これも価値)。
decidable: 各 (T,p,k) で π は決定可能。一般命題は未証明。
formal_verifiable: 各事例は decide 可。一般命題は open。
next: >
  - π(p,1) の閉形(固有値の mod p 乗法的順序の lcm)を明示。
  - 等式の証明 or 反例探索(p|det の μ_min>0 側も含め系統的に)。
  - 一般の整数行列でなく「可積分(YBE)」が効くか(R 行列構造が周期に与える制約)を問う。
references: [Pisano period(π(p^k)|p^{k-1}π(p)), Wall 1960, Wall–Sun–Sun 予想, D-U2 命題A]
notes: >
  正直: これは既知の難問(Wall 型)への接続で、解ければ大きいが未証明。本プロジェクトの寄与は
  可積分転送行列という構造付き設定での提起と系統的検証基盤。
```

## 最終更新（cycle 6）: 候補命題は棄却

`sagemath/check/cycle3_T3_period/wall_large_scale*`: 六頂点 L=2 を 572 件検査 → **Wall 破れ 26 件(≈4.5%)**（一般 2.1% と同等以上）。
⇒ **「可積分転送行列で Wall 等式が常に成立」は偽**。先の 0/43・0/91 は小標本の偶然（統計的有意性なしと注記済み）。
**残るのは rigorous 上界 $\pi(p,k)\mid p^{k-1}\pi(p,1)$ のみ**（これは不変）。可積分固有の Wall 特別性は無い。T3 のこの筋は否定的に決着。

## 経験的更新（cycle 4, `sagemath/check/cycle3_T3_period/wall_search*`）

反例探索の結果、上の候補命題は**修正が必要**:
- **Wall 等式は一般の整数行列では普遍でない**。退化例（$x^2-x+1$＝1 の冪根で有限位数, $(x-1)^2$＝unipotent でトレース定数）と、**非退化候補**（$x^2-2x-1$ Pell, $p=13$ で $\pi(p,2)=\pi(p,1)=28$）で破れる。
- 六頂点可積分転送行列はテスト範囲（5 種 ×4 素数）で **0 破れ**。
- ただし「可積分性が Wall を保証」は**未確定**: 一般側の破れは退化に交絡。**非退化に限定した系統比較**が必要（cycle 5+）。
- 不変なのは **rigorous 上界 $\pi(p,k)\mid p^{k-1}\pi(p,1)$**（これは保持）。等式は条件付き。

→ 候補命題の正しい形: 「**非退化な可積分転送行列**（固有値が 1 の冪根でない）で Wall 等式は成り立つか」。Pell 破れの存在から、無条件版は偽。

## D-U2 命題 A への還元（成果の統合）

T3 の上界により、D-U2 命題 A の「最終周期 $\pi(p,k)$」は $p^{k-1}\pi(p,1)$ で**上から押さえられ**、$\pi(p,1)$ は $GL_d(\mathbb{F}_p)$ の有限計算。よって命題 A の周期は明示上界つきで決定可能。Wall 等式が真なら**閉じた値**になる。
