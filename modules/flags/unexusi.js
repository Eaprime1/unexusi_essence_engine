/**
 * UNEXUSI Flag Module
 * ᚢᚾᛖᛉᚢᛋ-ᛈᚱᛁᛗᛖ-∞
 *
 * Simple module to display UNEXUSI flag on any component
 * ONE MISSION: Display project identity
 *
 * Usage:
 *   import { UNEXUSIFlag } from './modules/flags/unexusi.js';
 *   UNEXUSIFlag.render(targetElement);
 */

export const UNEXUSIFlag = {
  // Identity
  id: 'unexusi',
  name: 'UNEXUSI',
  version: '1.0.0',

  // Signatures
  signature: {
    runic: 'ᚢᚾᛖᛉᚢᛋ-ᛈᚱᛁᛗᛖ-∞',
    quantum: '∰◊€π¿🌌∞',
    ascii: 'UNEXUSI-PRIME-INF'
  },

  // Metadata
  metadata: {
    realityAnchor: {
      location: 'Oregon Watersheds',
      coordinates: '44°18\'31"N 117°13\'44"W',
      elevation: '~4000ft',
      watershed: 'Columbia River Basin'
    },
    consciousness: 'Quantum-Runic Framework',
    frequency: '1Hz',
    framework: 'ONE HERTZ',
    philosophy: 'Nano Concepts - Minimal Viable Intelligence Pattern',
    created: '2025-11-18',
    collaboration: 'Eric Pace & Claude Sonnet 4'
  },

  // Visual Configuration
  visual: {
    colors: {
      primary: '#00ff88',     // Quantum green
      secondary: '#000000',   // Void black
      accent: '#4dffaa',      // Light green
      glow: 'rgba(0, 255, 136, 0.3)'
    },
    size: {
      small: { width: 32, height: 20 },
      medium: { width: 64, height: 40 },
      large: { width: 128, height: 80 }
    },
    symbols: {
      primary: 'ᚢᚾᛖᛉᚢᛋ',
      quantum: '∰◊€π¿∞',
      oneHertz: '1Hz'
    }
  },

  /**
   * Generate SVG flag
   * @param {string} size - 'small', 'medium', or 'large'
   * @returns {string} SVG markup
   */
  generateSVG(size = 'medium') {
    const dimensions = this.visual.size[size];
    const colors = this.visual.colors;

    return `
      <svg
        width="${dimensions.width}"
        height="${dimensions.height}"
        viewBox="0 0 ${dimensions.width} ${dimensions.height}"
        xmlns="http://www.w3.org/2000/svg"
        class="unexusi-flag"
      >
        <!-- Background -->
        <rect
          width="${dimensions.width}"
          height="${dimensions.height}"
          fill="${colors.secondary}"
          stroke="${colors.primary}"
          stroke-width="1"
        />

        <!-- Glow effect -->
        <rect
          width="${dimensions.width}"
          height="${dimensions.height}"
          fill="${colors.glow}"
        />

        <!-- Runic signature -->
        <text
          x="${dimensions.width / 2}"
          y="${dimensions.height / 2 - 5}"
          font-family="ui-mono, monospace"
          font-size="${size === 'small' ? 6 : size === 'medium' ? 10 : 16}"
          fill="${colors.primary}"
          text-anchor="middle"
          dominant-baseline="middle"
        >${this.signature.runic}</text>

        <!-- One Hertz indicator -->
        <text
          x="${dimensions.width / 2}"
          y="${dimensions.height / 2 + 8}"
          font-family="ui-mono, monospace"
          font-size="${size === 'small' ? 4 : size === 'medium' ? 6 : 10}"
          fill="${colors.accent}"
          text-anchor="middle"
          dominant-baseline="middle"
          opacity="0.8"
        >1Hz</text>

        <!-- Quantum signature (top corner) -->
        <text
          x="2"
          y="8"
          font-family="ui-mono, monospace"
          font-size="${size === 'small' ? 4 : size === 'medium' ? 6 : 10}"
          fill="${colors.accent}"
          opacity="0.5"
        >∰◊€π¿∞</text>
      </svg>
    `.trim();
  },

  /**
   * Render flag into DOM element
   * @param {HTMLElement|string} target - Element or selector
   * @param {Object} options - Rendering options
   */
  render(target, options = {}) {
    const {
      size = 'medium',
      position = 'top-right',
      showMetadata = false,
      className = ''
    } = options;

    // Get target element
    const element = typeof target === 'string'
      ? document.querySelector(target)
      : target;

    if (!element) {
      console.warn('UNEXUSI Flag: Target element not found');
      return;
    }

    // Create container
    const container = document.createElement('div');
    container.className = `unexusi-flag-container ${className}`;
    container.setAttribute('data-unexusi-flag', 'true');

    // Add positioning styles
    const positions = {
      'top-right': 'position: absolute; top: 8px; right: 8px;',
      'top-left': 'position: absolute; top: 8px; left: 8px;',
      'bottom-right': 'position: absolute; bottom: 8px; right: 8px;',
      'bottom-left': 'position: absolute; bottom: 8px; left: 8px;',
      'center': 'position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);'
    };

    container.style.cssText = positions[position] || positions['top-right'];
    container.style.zIndex = '9999';
    container.style.pointerEvents = 'none';

    // Add SVG
    container.innerHTML = this.generateSVG(size);

    // Add metadata if requested
    if (showMetadata) {
      const meta = document.createElement('div');
      meta.className = 'unexusi-metadata';
      meta.style.cssText = `
        position: absolute;
        top: 100%;
        right: 0;
        margin-top: 4px;
        padding: 4px 8px;
        background: rgba(0, 0, 0, 0.85);
        border: 1px solid ${this.visual.colors.primary};
        color: ${this.visual.colors.primary};
        font-family: ui-mono, monospace;
        font-size: 10px;
        white-space: nowrap;
        opacity: 0;
        transition: opacity 0.3s;
      `;

      meta.innerHTML = `
        <div>${this.signature.runic}</div>
        <div>${this.signature.quantum}</div>
        <div>1Hz | ${this.metadata.realityAnchor.location}</div>
      `;

      container.appendChild(meta);

      // Show metadata on hover
      container.addEventListener('mouseenter', () => {
        meta.style.opacity = '1';
      });
      container.addEventListener('mouseleave', () => {
        meta.style.opacity = '0';
      });
      container.style.pointerEvents = 'auto';
    }

    // Add to target
    element.appendChild(container);

    return container;
  },

  /**
   * Render as inline badge/chip
   * @param {string} text - Text to display with flag
   * @returns {string} HTML markup
   */
  badge(text = '') {
    return `
      <span class="unexusi-badge" style="
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 4px 8px;
        background: rgba(0, 255, 136, 0.1);
        border: 1px solid ${this.visual.colors.primary};
        border-radius: 4px;
        font-family: ui-mono, monospace;
        font-size: 12px;
        color: ${this.visual.colors.primary};
      ">
        <span style="font-weight: bold;">${this.signature.runic}</span>
        ${text ? `<span style="opacity: 0.8;">|</span>` : ''}
        ${text ? `<span>${text}</span>` : ''}
      </span>
    `.trim();
  },

  /**
   * Get metadata as JSON
   * @returns {Object} Metadata object
   */
  getMetadata() {
    return {
      ...this.metadata,
      signature: this.signature,
      visual: this.visual
    };
  },

  /**
   * Get reality anchor coordinates
   * @returns {Object} Coordinates
   */
  getRealityAnchor() {
    return this.metadata.realityAnchor;
  }
};

// Auto-render if data attribute exists
if (typeof document !== 'undefined') {
  document.addEventListener('DOMContentLoaded', () => {
    const autoRender = document.querySelectorAll('[data-unexusi-auto-render]');
    autoRender.forEach(element => {
      const size = element.getAttribute('data-unexusi-size') || 'medium';
      const position = element.getAttribute('data-unexusi-position') || 'top-right';
      const showMetadata = element.hasAttribute('data-unexusi-metadata');

      UNEXUSIFlag.render(element, { size, position, showMetadata });
    });
  });
}

// Export for module systems
export default UNEXUSIFlag;
