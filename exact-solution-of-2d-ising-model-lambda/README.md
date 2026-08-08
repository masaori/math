# 2次元 Ising 模型の厳密解 — Λ と Fisher 零点の立場から

**このプロジェクトで作業する前に、必ずこの文書を読むこと。**
証明を書く・直す・形式化する・レビューするすべての判断が、ここに書かれたゴールに従う。

前提として、リポジトリ直下の [docs/context/](../docs/context/) を全て読むこと（三レイヤーの思想）。
本文書はその下位にあり、矛盾したら `docs/context/` が勝つ。

---

## ゴール

**2 次元正方格子 Ising 模型の厳密解を、可算な世界（$\mathbb{N}\subset\mathbb{Z}\subset\mathbb{Q}\subset\Lambda$、
$\mathbb{Z}[x]$、$\overline{\mathbb{Q}}$）で最大限まで進め、$\mathbb{R}/\mathbb{C}$ への脱出を
熱力学極限の一点へ隔離した形で導出する。**

到達したい形は次の 2 つである。

1. **有限系の側**：有限格子について述べることは、すべて可算な対象の厳密な等式・不等式として書く。
   分配関数は整係数多項式 $Z_L(x)\in\mathbb{Z}[x]$、その零点（Fisher 零点）は代数的数
   $\in\overline{\mathbb{Q}}$、有限系の自由エントロピーは $\Phi_L=\log Z_L(q)\in\Lambda$（素因数分解の指数ベクトル）。
   ここには $\mathbb{R}$ が一切現れない。
2. **極限の側**：自由エネルギー密度・零点密度・臨界指数など、$\mathbb{R}$ を要する量は
   **どこで・なぜ脱出したかを 1 ブロックずつ宣言した上で**扱う。脱出は「連続極限（$L\to\infty$）」
   「非解析性」「実対数・指数評価」に限り、それ以外の理由で $\mathbb{R}$ を呼ばない。

### 姉妹プロジェクトとの違い（重要）

| | [exact-solution-of-2d-ising-model](../exact-solution-of-2d-ising-model/) | 本プロジェクト |
| --- | --- | --- |
| 第一のゴール | **丁寧に積めば高校生でも読めること** | **可算と非可算の分別。$\mathbb{R}$ 脱出の隔離** |
| 土台 | 複素数とその行列（$\mathbb{C}$ から始める） | 数え上げ（$\mathbb{N}$）と整係数多項式（$\mathbb{Z}[x]$）から始める |
| 転送行列 | $M_{2^M}(\mathbb{C})$ の行列 | $M_{2^L}(\mathbb{Z}[x])$ の行列。固有値は特性多項式の根として代数的 |
| 指数関数 | 級数で定義して使う | **使わない**（$x=e^{-2\beta J}$ の代入をしない。形式変数 $x$ のまま進む） |
| 臨界点 | $\mathbb{R}$ 上の条件として | $\overline{\mathbb{Q}}$ の元 $x_c=\sqrt2-1$（自己双対方程式 $x^2+2x-1=0$ の正根） |
| 相転移 | 自由エネルギーの非解析性 | **零点が実軸へ詰め寄ること**（$\mathbb{Q}$ 上の量化言明） |

**同じ定理を二度証明するプロジェクトではない。** 姉妹プロジェクトは「読めること」を、
本プロジェクトは「どこまで可算で閉じるか」を第一の要求として持つ。したがって
証明経路そのものが変わる（例: 指数形 $e^{K\sigma\sigma'}$ を使わず、形式変数の単項式のまま進む）。
姉妹プロジェクト側で既に書かれた具体的な計算を参照してよいが、**引き写して満足しない**。
可算側で書き直せるかを毎回問う。

---

## この立場から来る記述の規則（本プロジェクト固有）

### 形式変数のまま進む。指数関数を入口に置かない

分配関数は $x$ を不定元とする多項式として定義する。

$$
Z_L(x)=\sum_{\sigma}x^{\,m(\sigma)}=\sum_{m}\Omega_L(m)\,x^{\,m}\in\mathbb{Z}[x]
$$

ここで $m(\sigma)\in\mathbb{N}$ は破れたボンドの本数、$\Omega_L(m)\in\mathbb{N}$ はその多重度（数え上げ）である。
**$x=e^{-2\beta J}$ の代入はしない。** 代入は $\mathbb{R}$ への脱出であり、それを避けることが本プロジェクトの中身だからである。
物理的な分配関数が要るときは、脱出であることを宣言した上で最後に代入する。

同じ理由で、**$\cosh$・$\sinh$・$\cos$ を解析関数として使わない。** 有限 $L$ で現れるこれらは
1 の冪根 $\omega$（円分体 $\mathbb{Q}(\omega)\subset\overline{\mathbb{Q}}$ の元）の有理式の別名にすぎない。
別名であることを本文で示してから使う。

### 量の住処を宣言する（型で強制される）

本文の各ブロックは、扱う量の住処 `habitat` を必ず宣言する
（可算側: `N` / `Z` / `Q` / `Lambda` / `Qbar` / `none`、非可算側: `R` / `C` / `mixed`）。
非可算側を宣言したブロックは `realEscape`（どこで・なぜ脱出したか）が必須であり、
可算側を宣言したブロックには `realEscape` を書けない。これは散文の約束ではなく
`structured-latex/schema.ts` の型と実行時検査で強制される。

### 「相転移」を可算な言明として書く

無限体積の非解析性を持ち出す前に、まず有限系の代数的データについての言明として書く。

$$
\forall\epsilon\in\mathbb{Q}_{>0}\ \exists L\in\mathbb{N}\ \exists j:\ \operatorname{dist}(x_j(L),\mathbb{R}_{>0})<\epsilon
$$

（距離の 2 乗は $\overline{\mathbb{Q}}$ の元なので、この述語は代数的数の比較で判定できる。）
非解析性そのものを述べるときだけ $\mathbb{R}$ へ出る。

### 使ってよい道具・使わない道具

| | 道具 | 扱い |
| --- | --- | --- |
| ○ | 有限集合の数え上げ、有限和・有限積 | 土台。$\mathbb{N}$ |
| ○ | 整係数多項式環 $\mathbb{Z}[x]$、その上の行列 | 土台 |
| ○ | 素因数分解と対数順序群 $\Lambda=\bigoplus_p\mathbb{Z}\ell_p$ | 有限系の自由エントロピーの住処 |
| ○ | 代数的数 $\overline{\mathbb{Q}}$、円分体 $\mathbb{Q}(\omega)$ | 零点と固有値の住処 |
| △ | $\mathbb{R}/\mathbb{C}$（連続極限・積分・非解析性・実対数） | **脱出箇所を宣言した場合のみ**。理由を書く |
| ✗ | $x=e^{-2\beta J}$ の無宣言の代入 | 脱出の隠蔽になる |
| ✗ | 解析関数としての $\cosh/\sinh/\cos$ | 有限 $L$ では代数的数の別名。別名であることを示して使う |
| ✗ | リー群・リー環、抽象テンソル積の一般論 | 姉妹プロジェクトと同じく使わない |
| ✗ | 一般の環・体へ持ち上げた主張 | 人手証明は具体に固定する（抽象化は Lean の中だけ） |

$\Lambda$ の定義・性質の一次情報は
[docs/discussion/対数順序群上の統計力学/](../docs/discussion/対数順序群上の統計力学/)、
零点プログラムの一次情報は
[docs/discussion/Lee-Yang-Fisher零点プログラム/](../docs/discussion/Lee-Yang-Fisher零点プログラム/) と
[docs/discussion/臨界指数をFisher零点列で書く/](../docs/discussion/臨界指数をFisher零点列で書く/)。

---

## 証明の四層検証（[docs/context/証明の書き方.md](../docs/context/証明の書き方.md) に従う）

| 層 | 何をするか | 置き場所 |
| --- | --- | --- |
| 記述 | 一ステップ一定理・根拠の明示・記号の帰属で人手証明を書く | `structured-latex/content/` |
| SageMath 検証 | 式変形を**一行ずつ**機械に確かめさせる（`ZZ`/`QQ`/`QQbar` で厳密に） | `sagemath/check/<対象名>/` |
| Lean 具体版 | 人手証明と **1 対 1 に対応する**証明 | `lean/Ising2DLambda/` |
| Lean 必要十分版 | 同じ手順のまま抽象度だけ必要十分まで上げる | `lean/Ising2DLambda/NecSuf/` |

**1 行も飛ばさない。定義のないトークンを使わない。すべてのトークンの所属を明示する。**
四層を全部満たせない段階では、どこまで済んでいるかを必ず明示する
（「記述と SageMath まで。Lean 未着手」）。黙って未検証のまま「証明した」と書かない。

SageMath 検証は浮動小数点を既定にしない。$\mathbb{R}$ 脱出を含む量を確認するときだけ使い、
使ったら `overview.md` に理由を記録する。

---

## 章立ての予定（名前で呼ぶ。番号を振らない）

| 章 | 内容 | 主な住処 |
| --- | --- | --- |
| 分配多項式 | 格子・配位・破れボンド数・多重度・$Z_L(x)\in\mathbb{Z}[x]$ | $\mathbb{N}$, $\mathbb{Z}[x]$ |
| 有限系の自由エントロピー | $\Phi_L=\log Z_L(q)\in\Lambda$（素因数分解の指数ベクトル） | $\Lambda$ |
| 転送行列 | $T(x)\in M_{2^L}(\mathbb{Z}[x])$ と $Z_L(x)=\operatorname{Tr}T(x)^L$ | $\mathbb{Z}[x]$ |
| 固有値の代数性 | 特性多項式 $\in\mathbb{Z}[x][\lambda]$、円分体上の対角化 | $\overline{\mathbb{Q}}$ |
| Fisher 零点 | 零点 $\in\overline{\mathbb{Q}}$、Kramers–Wannier 双対、$x_c=\sqrt2-1$ | $\overline{\mathbb{Q}}$ |
| 零点の詰め寄り | 相転移を $\mathbb{Q}$ 上の量化言明として書く | $\mathbb{Q}$, $\overline{\mathbb{Q}}$ |
| 熱力学極限 | 自由エネルギー密度・零点密度。**ここが $\mathbb{R}$ 脱出** | $\mathbb{R}$ |
| 臨界指数を零点列で書く | 先頭零点列 $\{x_1(L)\}_L\subset\overline{\mathbb{Q}}$ と有限サイズスケーリング | mixed |

読む順序はこの表が正本である。**ファイル名に連番を付けない**（リポジトリ直下 [CLAUDE.md](../CLAUDE.md)
「文書・定理を番号や記号で管理しない」）。文書順は `content/` の各ファイル内の配列の並びで決まる。
現状は 1 ファイル構成であり、**ファイルを分けるときは文書順の決め方を先に決める**
（システムはファイル名昇順を文書順とみなすため、連番を使わない規約と衝突する。未解決。`MEMORY.md` 参照）。

---

## 構成と検証コマンド

```text
exact-solution-of-2d-ising-model-lambda/
├── README.md                  # このファイル（ゴール設定）
├── MEMORY.md                  # 引き継ぎメモ
├── structured-latex/          # 証明の正本（構造化テキスト）
│   ├── schema.ts              #   入力言語はシステム側。ここは固有メタデータの宣言だけ
│   ├── content/               #   本文（最終成果物はここだけから生成する）
│   ├── notes/                 #   参照用ノート（出版物には載らない）
│   └── tools/                 #   検査・生成
├── sagemath/                  # 厳密計算による式変形の裏取り
├── lean/                      # 形式検証（具体版と必要十分版）
└── docs/tasks/                # 作業指示書
```

```sh
(cd structured-latex && pnpm install)   # 初回のみ（Node 22.18 以降）
(cd structured-latex && npm run gen)    # ラベル・集約モジュールの再生成
(cd structured-latex && npm run check)  # 生成物の鮮度 → 型検査 → 実行時検証 → 負テスト
node sagemath/tools/verify-check-linkage.ts   # 検証 ↔ 証明の対応
(cd lean && lake build && bash scripts/check-no-sorry.sh)
```

閲覧（リポジトリ直下のビューアをこのプロジェクトへ向ける）:

```sh
(cd structured-latex/live-preview && \
  LIVE_PREVIEW_SOURCE_DIR=../../exact-solution-of-2d-ising-model-lambda/structured-latex/content pnpm start)
```
