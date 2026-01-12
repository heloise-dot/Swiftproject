# Water Utility App - Design System Documentation

## Overview
This document outlines the design system improvements made to create a production-ready, professional water utility application. The design prioritizes trust, clarity, and accessibility while maintaining a modern, water-inspired aesthetic.

## Design Principles

### 1. Trust & Reliability
- **Color Palette**: Deep ocean blues and calm teals convey trust and professionalism
- **Typography**: Clear hierarchy ensures information is easily digestible
- **Consistency**: Uniform spacing, colors, and components build user confidence

### 2. Accessibility (WCAG AA Compliance)
- **Contrast Ratios**: All text meets WCAG AA standards (4.5:1 minimum)
- **Touch Targets**: Minimum 44x44pt for all interactive elements
- **Labels**: Clear, descriptive labels for all actions
- **Color Independence**: Status indicators use both color and text/shape

### 3. Clarity & Efficiency
- **Visual Hierarchy**: Information prioritized by importance
- **Spacing Scale**: Consistent spacing (4pt, 8pt, 16pt, 24pt, 32pt, 48pt)
- **Typography Scale**: Clear font sizing from display (56pt) to caption (12pt)
- **Reduced Cognitive Load**: Minimal decoration, focus on content

## Color System

### Primary Colors
- **Primary Blue** (`#0B6BC2`): Deep ocean blue for trust and reliability
- **Primary Teal** (`#14B8A6`): Water-inspired accent color

### Semantic Colors
- **Success** (`#10B981`): Water available, system operational
- **Warning** (`#F59E0B`): Low pressure, scheduled maintenance
- **Error** (`#EF4444`): Outage, critical issues
- **Info** (`#3B82F6`): Neutral informational states

### Status Colors
- **Available**: `#10B981` (Emerald)
- **Low Pressure**: `#F59E0B` (Amber)
- **Maintenance**: `#F97316` (Orange)
- **Outage**: `#EF4444` (Red)

### Background Colors
- **Background Dark**: `#0F172A` (Slate 900)
- **Card Dark**: `#1E293B` (Slate 800) - 100% opacity for better contrast
- **Surface Secondary**: `#334155` (Slate 700) - for nested containers

### Text Colors
- **Text Primary**: `#F8FAFC` (Slate 50) - WCAG AAA contrast
- **Text Secondary**: `#CBD5E1` (Slate 300) - WCAG AA contrast
- **Text Tertiary**: `#94A3B8` (Slate 400) - for subtle labels

## Typography Scale

### Display (Large Numbers)
- **Display Large**: 56pt, Bold, Rounded - for usage stats, totals
- **Display Medium**: 48pt, Bold, Rounded - for secondary metrics

### Headings
- **Heading 1**: 32pt, Bold - section titles
- **Heading 2**: 24pt, Semibold - subsection titles
- **Heading 3**: 20pt, Semibold - card titles

### Body Text
- **Body Large**: 17pt, Regular - primary body text
- **Body Medium**: 15pt, Regular - standard body text
- **Body Small**: 13pt, Regular - supporting text

### Labels & Captions
- **Label Medium**: 15pt, Medium - button labels
- **Label Small**: 13pt, Medium - field labels
- **Caption**: 12pt, Regular - timestamps, metadata

## Spacing Scale

Consistent spacing ensures visual rhythm and professional appearance:
- **XS**: 4pt - tight spacing (e.g., icon to text)
- **SM**: 8pt - compact spacing (e.g., between related elements)
- **MD**: 16pt - standard spacing (e.g., card padding)
- **LG**: 24pt - section spacing
- **XL**: 32pt - major section breaks
- **XXL**: 48pt - page-level spacing

## Component Library

### Buttons
- **PrimaryButton**: 50pt height, accessible touch target, shadow for depth
- **SecondaryButton**: Outlined style for less prominent actions
- **DestructiveButton**: Red variant for critical actions (sign out, delete)

### Status Indicators
- **StatusBadge**: Capsule shape, high contrast, three sizes (small, medium, large)
- **WaterStatusBadge**: Specialized variant for water status indicators

### Cards
- **StatusCard**: Area status display with clear hierarchy
- **InfoCard**: Key metrics display with icon, title, and value

### Form Elements
- **AnimatedToggle**: Accessible toggle with clear labels
- **TextField**: Consistent styling with focus states

## Accessibility Features

1. **Touch Targets**: All interactive elements minimum 44x44pt
2. **Contrast**: All text meets WCAG AA standards (WCAG AAA for primary text)
3. **Labels**: Descriptive labels for all interactive elements
4. **Focus States**: Clear visual indicators for keyboard navigation
5. **Color Independence**: Status uses both color and text/shape
6. **Font Scaling**: Supports Dynamic Type for accessibility preferences

## Responsive Design Considerations

While primarily designed for iOS, the spacing and typography scales work well across:
- **Mobile**: iPhone (all sizes)
- **Tablet**: iPad (landscape and portrait)
- **Desktop**: Mac Catalyst (future consideration)

## Usage Guidelines

### When to Use Primary Blue
- Primary actions (Sign In, Save, Submit)
- Links and navigation
- Brand elements

### When to Use Semantic Colors
- **Success**: Water available, completed actions
- **Warning**: Low pressure, attention needed
- **Error**: Outages, critical issues, destructive actions
- **Info**: Neutral information, secondary actions

### Spacing Best Practices
- Use spacing scale consistently
- Group related elements with smaller spacing (SM/MD)
- Separate sections with larger spacing (LG/XL)
- Use padding for breathing room around content

### Typography Best Practices
- Use Heading 1 for main screen titles
- Use Heading 2 for section headers
- Use Body Medium for most content
- Reserve Display fonts for key metrics
- Use Caption for timestamps and metadata

## Implementation Notes

- All components include accessibility labels
- Haptic feedback used for important interactions
- Subtle animations for state changes (spring animations)
- Shadow and elevation used sparingly for depth
- Focus on readability over decoration
- Production-ready code with comments explaining design decisions

## Future Enhancements

1. Light mode support (currently dark mode optimized)
2. Custom color schemes for different utility organizations
3. Enhanced animations for micro-interactions
4. Darker theme variants for low-light environments
5. High contrast mode for users with visual impairments

