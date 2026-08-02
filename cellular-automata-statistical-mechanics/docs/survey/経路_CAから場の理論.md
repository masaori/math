# 経路: CA から場の理論（Grassmann・Dirac・量子形式）

**一言**: 「CA を場の理論として書き直す」試みは 3 系統ある。
(i) 決定論的 CA に Hilbert 空間を被せる（'t Hooft）、
(ii) 確率的 CA を Grassmann 汎関数積分で書く（Wetterich）、
(iii) 量子 CA の連続極限として Dirac 方程式を出す（Bisio–D'Ariano ら）。
**いずれも「有限・可算な CA データ → 連続的な場の理論」という向きで、脱出点が明確**。

## 't Hooft — CA 解釈

't Hooft, *The Cellular Automaton Interpretation of Quantum Mechanics*,
Fundamental Theories of Physics **185**, Springer (2016), arXiv:1405.1548（オープンアクセス）。

- 「自然の状態は整数の列で与えられ、時間発展は古典的アルゴリズムである」という設定。
- 決定論的な CA に Hilbert 空間の形式を被せる：状態を正規直交基底（**オントロジー基底**）とし、
  時間発展を**置換行列** $U$ で表す。Hamiltonian は $H=\frac{i}{\Delta t}\log U$。
- 基底の取り替え（ユニタリ変換）で、決定論的な系が量子的に見えることを示す模型群
  （cogwheel model 等）を与えている。

### 可算性の観点（本プロジェクトにとっての要点）

有限系（周期 $L$ の可逆 CA）では：

- $U$ は $2^L\times2^L$ の**置換行列**（成分 $\in\{0,1\}$）。
- $U$ の位数は有限（$U^m=I$）ので、**固有値は 1 の冪根** $\zeta\in\mu_m\subset\overline{\mathbb{Q}}$。
- したがって「エネルギー」は $E=\frac{2\pi k}{m\Delta t}$ の形で、
  **$\mathbb{R}$ 脱出は定数 $2\pi$（と $\Delta t$ の選択）だけ**。位相を $\mathbb{Q}/\mathbb{Z}$ で書けば脱出はゼロ。
- $Z_N=\operatorname{Tr}U^N=\#\{\text{周期 }N\text{ の配位}\}\in\mathbb{N}$。

**すなわち、可逆 CA の「量子論」はスペクトル理論まで含めて完全に可算**である
（→ 種「可逆CAの量子論は可算」）。これは `docs/research/場の量子論の数学的定式化/10_可算性から見た場の量子論.md` の課題「Hamiltonian $=\frac{i}{\Delta t}\log U$ の可算化」への具体的な回答になる。

**注意**: 本プロジェクトは 't Hooft 解釈の物理的・哲学的な当否には立ち入らない
（README の「やらないこと」節）。使うのは「決定論的 CA → 置換行列 → 可算スペクトル」という数学的な部分だけ。

## Wetterich — 確率的 CA ＝ フェルミオン QFT

- Wetterich, "Probabilistic cellular automata for interacting fermionic quantum field theories",
  *Nucl. Phys. B* **963** (2021) 115297, arXiv:2007.06366。
- Wetterich, "Fermionic quantum field theories as probabilistic cellular automata",
  *Phys. Rev. D* **105** (2022) 074502, arXiv:2111.06728。
- Wetterich, "Fermion picture for cellular automata", arXiv:2203.14081。

**主張**:

- 相互作用を持つあるクラスのフェルミオン量子場理論は、**確率的 CA**（初期状態に確率分布を
  持つ CA）と**等価**である。
- 1 次元格子上の PCA は 2 次元のフェルミオン場の理論と等価であり、
  これは正方格子上の**一般化 Ising 模型**＝古典統計系とみなせる。
  「量子力学が古典統計から現れる」。
- 具体例として**離散化された Thirring 模型**を CA として記述。ユニタリな時間発展を持ち、
  量子力学のすべての性質を示す。自発的対称性の破れ・ソリトンを持つ。
- 技術的な核: 局所更新規則を持つ空間格子上の可逆 CA は、
  **相互作用するフェルミオンの分配関数（Grassmann 汎関数積分）で書ける**。
  確率的 CA には波動関数・密度行列・非可換作用素という量子形式が使える。

### 可算性の観点

有限格子の Grassmann 積分は、**有限次元外積代数における最高次成分の係数抽出**であり、
解析的な積分ではない。値は Pfaffian／行列式で $\mathbb{Z}$ または $\mathbb{Q}$ に住む。
つまり **「CAから場の理論」の経路の核心部分（有限格子）は完全に代数的・可算**（見かけだけの $\mathbb{R}$ 脱出）。

$\mathbb{R}$ に出るのは (i) 連続極限、(ii) 重みを $\exp$ で書く段（指数評価または極限による $\mathbb{R}$ 脱出）。
Wetterich 自身は連続極限を目標にしているので、可算側で閉じる範囲は明示されていない。
**この切り分けは本プロジェクトが埋められる空白**。

## 量子 CA から Dirac 方程式

Bisio–D'Ariano–Tosini, "Quantum field as a quantum cellular automaton: the Dirac free evolution
in one dimension", *Ann. Phys.* **354** (2015) 244; D'Ariano–Perinotti, "Derivation of the Dirac
equation from principles of information processing", *Phys. Rev. A* **90** (2014) 062106;
Bisio–D'Ariano–Perinotti, "Quantum cellular automaton theory of light";
Arrighi ほか（総説 arXiv:1904.12956）。

- 均質性・パリティ・時間反転不変性という原理から、$1$ 次元の QCA として Dirac 方程式が
  **創発**する（小さい波数・質量の極限で Dirac 力学を再現）。
- Zitterbewegung、ポテンシャルからの散乱、Klein パラドックスといった Dirac 力学の特徴を示す。
- Weyl・Dirac・Maxwell QCA（*Found. Phys.* **45** (2015) 1203）。
- 量子ウォークとしての実装、イオントラップ量子計算機での実験
  （*Nat. Commun.* **11** (2020) 3720）。

### 可算性の観点

QCA の局所ゲートは有限次元ユニタリ行列で、多くの構成では成分が $\overline{\mathbb{Q}}$
（$\sqrt2$、1 の冪根など）。**有限時間・有限系の議論は $\overline{\mathbb{Q}}$ で閉じる。**
Dirac 方程式が出るのは分散関係の**小波数展開**＝極限・積分による $\mathbb{R}$ 脱出の脱出。

## Reggeon 場の理論（古典的な橋）

有向浸透（DP）普遍類 ↔ Reggeon 場の理論（非ユニタリ QFT）の対応（Cardy–Sugar 1980）。
Domany–Kinzel CA は DP 普遍類の標準的な CA 実現（→ 「転送行列と確率的CA」の経路 「量子 CA から Dirac 方程式」節）。
**CA → 場の理論の最も古い明示的な橋**で、繰り込み群による普遍類の同定という形をとる。

## この経路の空白

1. **有限格子で閉じる部分と連続極限を要する部分の切り分けが、どの系統でも書かれていない。**
   Wetterich の Grassmann 表示は有限格子では純代数的（Pfaffian $\in\mathbb{Z}$）だが、
   その事実は強調されていない。
2. **可逆 CA の置換行列としてのスペクトル（1 の冪根）が、
   統計力学量（$Z_N$、$\Phi_N\in\Lambda$）と結ばれていない。**
   $\operatorname{Tr}U^N$ は周期点の数え上げであり、`R-Lambda-duality` の枠組みが直接使える（→ 種「可逆CAの量子論は可算」）。
3. **場の理論側の「作用素代数」と CA の規則の対応が、「量子CAの指数理論」の経路（QCA 指数）と分断されている。**
   Dirac QCA の GNVW 指数は何か、という自然な問いへの答えを見ていない。
