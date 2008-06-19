/*=========================================================================

  Program:   CMake - Cross-Platform Makefile Generator
  Module:    $RCSfile$
  Language:  C++
  Date:      $Date$
  Version:   $Revision$

  Copyright (c) 2002 Kitware, Inc. All rights reserved.
  See Copyright.txt or http://www.cmake.org/HTML/Copyright.html for details.

     This software is distributed WITHOUT ANY WARRANTY; without even 
     the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
     PURPOSE.  See the above copyright notices for more information.

=========================================================================*/

#ifndef cmCPackComponentGroup_h
#define cmCPackComponentGroup_h

#include <map>
#include <string>
#include <vector>

class cmCPackComponentGroup;

/** \class cmCPackInstallationType
 * \brief A certain type of installation, which encompasses a 
 * set of components.
 */
class cmCPackInstallationType
{
public:
  /// The name of the installation type (used to reference this
  /// installation type).
  std::string Name;

  /// The name of the installation type as displayed to the user.
  std::string DisplayName;

  /// The index number of the installation type. This is an arbitrary
  /// numbering from 1 to the number of installation types.
  unsigned Index;
};

/** \class cmCPackComponent
 * \brief A single component to be installed by CPack.
 */
class cmCPackComponent
{
public:
  cmCPackComponent() : Group(0) { }

  /// The name of the component (used to reference the component).
  std::string Name;

  /// The name of the component as displayed to the user.
  std::string DisplayName;

  /// The component group that contains this component (if any).
  cmCPackComponentGroup *Group;

  /// Whether this component group must always be installed.
  bool IsRequired : 1;

  /// Whether this component group is hidden. A hidden component group
  /// is always installed. However, it may still be shown to the user.
  bool IsHidden : 1;

  /// Whether this component defaults to "disabled".
  bool IsDisabledByDefault : 1;

  /// A description of this component.
  std::string Description;

  /// The installation types that this component is a part of.
  std::vector<cmCPackInstallationType *> InstallationTypes;

  /// The components that this component depends on.
  std::vector<cmCPackComponent *> Dependencies;

  /// The components that depend on this component.
  std::vector<cmCPackComponent *> ReverseDependencies;

  /// The list of installed files that are part of this component.
  std::vector<std::string> Files;

  /// The list of installed directories that are part of this component.
  std::vector<std::string> Directories;
};

/** \class cmCPackComponentGroup
 * \brief A component group to be installed by CPack.
 */
class cmCPackComponentGroup
{
public:
  /// The name of the group (used to reference the group).
  std::string Name;

  /// The name of the component as displayed to the user.
  std::string DisplayName;

  /// The description of this component group.
  std::string Description;

  /// Whether the name of the component will be shown in bold.
  bool IsBold : 1;

  /// Whether the section should be expanded by default
  bool IsExpandedByDefault : 1;

  /// The components within this group.
  std::vector<cmCPackComponent*> Components;
};

#endif