// $Id: AMPacket.nc,v 1.2 2006/07/12 17:02:12 scipio Exp $
/*									tab:4
 * "Copyright (c) 2004-5 The Regents of the University  of California.  
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 * 
 * IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF
 * CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATION TO
 * PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS."
 *
 * Copyright (c) 2004-5 Intel Corporation
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached INTEL-LICENSE     
 * file. If you do not find these files, copies can be found by writing to
 * Intel Research Berkeley, 2150 Shattuck Avenue, Suite 1300, Berkeley, CA, 
 * 94704.  Attention:  Intel License Inquiry.
 */

/**
  * The Active Message accessors, which provide the AM local address and
  * functionality for querying packets. Also see the Packet interface.
  *
  * @author Philip Levis 
  * @date   January 18 2005
  * @see    Packet
  * @see    AMSend
  * @see    TEP 116: Packet Protocols
  */ 


#include <message.h>
#include <AM.h>

interface AMPacket {

  /**
   * Return the node's active message address associated with this AM stack.
   * @return The address
   */

  command am_addr_t address();

  /**
   * Return the AM address of the destination field of an AM packet.
   * If <tt>amsg</tt> is not an AM packet, the results of this command
   * are undefined.
   * @param amsg    the packet
   * @return        the destination address of the packet.
   */
  
  command am_addr_t destination(message_t* amsg);

  /**
   * Set the AM address of the destination field of the AM packet.  As
   * the AM address is set as part of sending with the AMSend
   * interface, this command is not used for sending packets.  Rather,
   * it is used when a component, such as a queue, needs to buffer a
   * request to send. The component can save the destination address
   * and then recover it when actually sending. If <tt>amsg</tt> is
   * not an AM packet, the results of this command are undefined.
   *
   * @param  amsg   the packet
   * @param  addr   the address
   */

  command void setDestination(message_t* amsg, am_addr_t addr);

  /**
   * Return whether <tt>amsg</tt> is destined for this mote. This is
   * partially a shortcut for testing whether the return value of
   * <tt>destination</tt> and <tt>address</tt> are the same. It
   * may, however, include additional logic. For example, there
   * may be an AM broadcast address: <tt>destination</tt> will return
   * the broadcast address, but <tt>address</tt> will still be
   * the mote's local address. If <tt>amsg</tt> is not an AM packet,
   * the results of this command are undefined.
   *
   * @param  amsg   the packet
   * @return        whether the packet is addressed to this AM stack
   */
  command bool isForMe(message_t* amsg);
  
  /**
   * Return the AM type of the AM packet.
   * If <tt>amsg</tt> is not an AM packet, the results of this command
   * are undefined.
   *
   * @param  amsg   the packet
   * @return        the AM type
   */
  
  command am_id_t type(message_t* amsg);

  /**
   * Set the AM type of the AM packet.  As the AM type is set as part
   * of sending with the AMSend interface, this command is not used
   * for sending packets. Instead, it is used when a component, such
   * as a queue, needs to buffer a request to send. The component can
   * save the AM type in the packet then recover it when actually
   * sending. If <tt>amsg</tt> is not an AM packet, the results of
   * this command are undefined.
   * 
   * @param  amsg    the packet
   * @param  t       the AM type
   */
  
  command void setType(message_t* amsg, am_id_t t);

}